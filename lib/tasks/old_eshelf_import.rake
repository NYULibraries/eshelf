namespace :nyu do
  namespace :old_eshelf do
    require 'activerecord-import'
    desc "Import users, records and tags from the old eshelf to the new"
    task :import => [:import_users, :import_records, :import_tags]

    desc "Import users from the old eshelf to the new"
    task :import_users => :environment do |task,args|
      users = []
      old_users = OldEshelf::OldUser.accessed_this_year.reject(&:expired?)
      old_users.each do |old_user|
        # Don't do anything if there are no old records to import
        next if old_user.old_records.empty?
        users << User.first_or_initialize_from_old_user(old_user)
      end
      User.import users
      puts "[SUCCESS] #{users.count} users imported."
    end

    desc "Import records from the old eshelf to the new"
    task :import_records => :environment do |task,args|
      records = []
      old_users = OldEshelf::OldUser.accessed_this_year.reject(&:expired?)
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
        # Create locations once we have the records
        # NOTE: This sucks. Sorry.
        Record.all.each do |record|
          record.becomes_external_system.create_locations_from_external_system
        end
        puts "[SUCCESS] #{records.count} records imported."
      rescue => e
        error = /ActiveRecord::JDBCError: com\.mysql\.jdbc\.(.+?): (.+?): INSERT INTO/.match(e.message)
        unless error.captures.blank?
          raise Exception, "#{e}\n[ActiveRecord::JDBCError] #{error.captures.first}: #{error.captures.last}"
        end
      end

    end

    desc "Import tags from the old eshelf to the new"
    task :import_tags => :environment do |task,args|
      old_users = OldEshelf::OldUser.accessed_this_year.reject(&:expired?)
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
