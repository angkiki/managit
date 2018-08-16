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
  ["Implement Geocoder", "pending", angkiki.id, Date.today.last_week],
  ["Set Up Action Mailer", "pending", angkiki.id, Date.today - 5.days],
  ["Settle Listings and Items Model", "pending", angkiki.id, Date.today - 4.days],
  ["Devise is Not Working", "bugs", tank.id, Date.today - 4.days],
  ["Set Up Devise for Buyers", "pending", tank.id, Date.today - 2.days]
]

features.each do |f|
  Feature.create(name: f[0], status: f[1], user_id: f[2], project_id: project.id, created_at: f[3])
end
