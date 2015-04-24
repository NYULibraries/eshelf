# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# Set up a development user
user = User.find_by_username('hero123')
if Rails.env.development?
  if user.nil?
    user = User.create!({username: 'hero123', firstname: 'Herodotus', lastname: 'de Lyxes', email: 'herodotus@histories.edu'})
  end
  user.records.destroy_all
  user.records.new({external_id: 'nyu_aleph000864162', external_system: 'primo'}).becomes_external_system.save!
  user.records.new({external_id: 'nyu_aleph002406797', external_system: 'primo'}).becomes_external_system.save!
end
