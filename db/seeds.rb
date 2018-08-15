# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

angkiki = User.create(username: 'angkiki', email: 'angkiki@test.com', password: '123456')
tank = User.create(username: 'tank', email: 'tank@test.com', password: '123456')
jodich = User.create(username: 'jodich', email: 'jodich@test.com', password: '123456')

project = Project.create(title: 'Karang Guni App', owner: angkiki.id)
project.users << [angkiki, tank]

pu1 = ProjectUser.find_by(project_id: project.id, user_id: tank.id)
pu1.update_attributes(status: 1)

features = [
  ["Implement Geocoder", "pending", angkiki.id],
  ["Set Up Action Mailer", "pending", angkiki.id],
  ["Settle Listings and Items Model", "pending", angkiki.id],
  ["Devise is Not Working", "bugs", tank.id],
  ["Set Up Devise for Buyers", "pending", tank.id]
]

features.each do |f|
  Feature.create(name: f[0], status: f[1], user_id: f[2], project_id: project.id)
end
