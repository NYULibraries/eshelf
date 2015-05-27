namespace :nyu do
  namespace :old_eshelf do
    require 'activerecord-import'
    desc "Import users, records and tags from the old eshelf to the new"
    task :import => [:import_users, :import_records, :import_tags]

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
      records = []
      old_users.each do |old_user|
        # Don't do anything if there are no old records to import
        next if old_user.old_records.empty?
        user = User.find_by_username(old_user.username)
        next unless user
        records << user.initialize_records_from_old_user(old_user)
      end
      records.flatten!
      Record.record_timestamps = false
      begin
        # Perform a basic update on duplicate key found
        Record.import records, validate: false, on_duplicate_key_update: [:title, :title_sort, :author, :url]
        puts "[SUCCESS] #{records.count} records imported."
        # Set citero object out here so we can reuse it for all the records
        # @citero = Citero
        # # Create locations once we have the records
        # # Set openurl from citero after loading them into database
        # # NOTE: This sucks. Sorry.
        # Record.find_each(start: 0, batch_size: 2000) do |record|
        #   record.url = @citero.map(record.data).send("from_#{record.format}").to_openurl
        #   normalized = @citero.map(record.data).send("from_#{record.format}").csf
        #   if record.format == "xerxes_xml"
        #     [:title, :author, :content_type].each do |field|
        #       normalized_field = (normalized.respond_to?(field)) ? normalized.send(field).join("; ") : record.send(field)
        #       record.send("#{field}=", normalized_field)
        #     end
        #   end
        #   record.becomes_external_system.create_locations_from_external_system
        #   record.save!
        # end
        puts "[SUCCESS] #{records.count} records updated."
      rescue => e
        error = /ActiveRecord::JDBCError: com\.mysql\.jdbc\.(.+?): (.+?): INSERT INTO/.match(e.message)
        unless error.captures.blank?
          raise Exception, "#{e}\n[ActiveRecord::JDBCError] #{error.captures.first}: #{error.captures.last}"
        else
          raise Exception, "#{e}"
        end
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

def cache
  @cache ||= ActiveSupport::Cache::MemoryStore.new(expires_in: 24.hours)
end
