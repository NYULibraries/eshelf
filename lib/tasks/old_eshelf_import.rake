namespace :nyu do
  namespace :old_eshelf do
    require 'activerecord-import'        
    desc "Import users, records and tags from the old eshelf to the new"
    task :import => [:import_users, :import_records, :import_tags]

    desc "Import users from the old eshelf to the new"
    task :import_users => :environment do |task,args|
      users = []
      OldEshelf::OldUser.accessed_this_year.each do |old_user|
        # Don't do anything if there are no old records to import
        next if old_user.old_records.empty?
        users << User.first_or_initialize_from_old_user(old_user)
      end
      User.import users
    end

    desc "Import records from the old eshelf to the new"
    task :import_records => :environment do |task,args|
      records = []
      OldEshelf::OldUser.accessed_this_year.each do |old_user|
        # Don't do anything if there are no old records to import
        next if old_user.old_records.empty?
        user = User.find_by_username(old_user.username)
        next unless user
        records << user.initialize_records_from_old_user(old_user)
      end
      records.flatten!
      Record.record_timestamps = false
      Record.import records, validate: false
      # Create locations once we have the records
      # NOTE: This sucks. Sorry.
      Record.all.each do |record|
        record.becomes_external_system.create_locations_from_external_system
      end
    end

    desc "Import tags from the old eshelf to the new"
    task :import_tags => :environment do |task,args|
      OldEshelf::OldUser.accessed_this_year.each do |old_user|
        # Don't do anything if there are no old records to import
        next if old_user.old_records.empty?
        user = User.find_by_username(old_user.username)
        next unless user
        user.tag_records_from_old_user(old_user)
      end
    end
  end
end
