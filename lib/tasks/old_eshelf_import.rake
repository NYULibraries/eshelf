namespace :nyu do
  namespace :old_eshelf do
    require 'activerecord-import'
    desc "Import users, records and tags from the old eshelf to the new"
    task :import => [:import_users, :import_records, :update_imported_records, :import_tags]

    desc "Import users from the old eshelf to the new"
    task :import_users => :environment do |task,args|
      users = []
      old_users.each do |old_user|
        # Don't do anything if there are no old records to import
        next if old_user.old_records.empty?
        users << User.first_or_initialize_from_old_user(old_user)
      end
      User.import users, validate: false
      puts "[SUCCESS] #{users.count} users imported."
    end

    desc "Import records from the old eshelf to the new"
    task :import_records => :environment do |task,args|
      # Keep the logger quiet during this or it will run out of space
      ActiveRecord::Base.logger.silence do
        old_users.find_in_batches(batch_size: 100) do |old_user_group|
          records = []
          old_user_group.each do |old_user|
            # Don't do anything if there are no old records to import
            next if old_user.old_records.empty?
            user = User.find_by_username(old_user.username)
            next unless user
            records << user.initialize_records_from_old_user(old_user)
          end

          records.flatten!
          Record.record_timestamps = false
          Record.import records, validate: false, on_duplicate_key_update: [:title, :title_sort, :author, :url]
          puts "[SUCCESS] #{records.count} records imported."
        end
      end
    end

    desc "Update imported records with info normalized from citero"
    task :update_imported_records => :environment do |task,args|
      ActiveRecord::Base.logger.silence do
        # Set citero object out here so we can reuse it for all the records
        @citero = Citero
        # Create locations once we have the records
        # Set openurl from citero after loading them into database
        # NOTE: This sucks. Sorry.
        locations = records = 0
        Record.find_each(batch_size: 100) do |record|
          begin
            record.url = @citero.map(record.data).send("from_#{record.format}").to_openurl
            if record.format == "xerxes_xml"
              normalized = @citero.map(record.data).send("from_#{record.format}").csf
              [:title, :author, :content_type].each do |field|
                normalized_field = (normalized.respond_to?(field) && normalized.send(field).present?) ? normalized.send(field).join("; ") : record.send(field)
                record.send("#{field}=", normalized_field)
              end
            end
          rescue => e
            if record.format == "xerxes_xml"
              log.info("[XERXES; ID=#{record.id}] #{record.format} Could not load record from CSF: #{e}")
            elsif record.format == "primo"
              log.info("[PRIMO; ID=#{record.id}] #{record.format} Could not load record from CSF: #{e}")
            end
          end

          begin
            record.becomes_external_system.create_locations_from_external_system
            locations += 1
          rescue => e
            if record.format == "xerxes_xml"
              log.info("[XERXES; ID=#{record.id}] #{record.format} Could not create locations.")
            elsif record.format == "primo"
              log.info("[PRIMO; ID=#{record.id}] #{record.format} Could not create locations.")
            end
          end
          record.save! validate: false
          records += 1
        end
        puts "[SUCCESS] #{records.count} records updated."
        puts "[SUCCESS] #{locations.count} locations added."
      end
    end

    desc "Import tags from the old eshelf to the new"
    task :import_tags => :environment do |task,args|
      old_users.each do |old_user|
        # Don't do anything if there are no old records to import
        next if old_user.old_records.empty?
        user = User.find_by_username(old_user.username)
        next unless user
        user.tag_records_from_old_user(old_user)
      end
      puts "[SUCCESS] Finishes importing tags."
    end
  end
end

def old_users
  @old_users ||= cache.fetch('old_users') do
    OldEshelf::OldUser.with_records
  end
end

def log
  @log ||= Logger.new(Rails.root.join('log','old_eshelf_cron_error.log'))
end

def cache
  @cache ||= ActiveSupport::Cache::MemoryStore.new(expires_in: 24.hours)
end
