# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# Set up a development user
if Rails.env.development? and User.find_by_username('developer').nil?
  user = User.create!({username: 'developer', firstname: 'Dev', lastname: 'Eloper', email: 'developer@university.edu'})
  user.records.new({external_id: 'nyu_aleph000980206', external_system: 'primo'}).becomes_external_system.save!
end
