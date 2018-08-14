namespace :eshelf do
  desc "Change format xerxes_xml to openurl and move url into data field"
  task :update_xerxes_records => :environment do |task,args|
    # Keep the logger quiet during this or it will run out of space
    ActiveRecord::Base.logger.silence do
      rs = 0
      Record.where(external_system: 'xerxes').find_in_batches(batch_size: 100) do |array_of_records|
        ids = array_of_records.collect(&:id)
        Record.where(id: ids).each do |record|
          # record.data_xerxes_xml = record.data
          # record.data = "https://getit.library.nyu.edu/resolve?#{record.url}"
          # record.format = "openurl"
          # record.save!
          rs += 1
        end
      end
      puts "Will update #{rs} records"
    end
  end
end
