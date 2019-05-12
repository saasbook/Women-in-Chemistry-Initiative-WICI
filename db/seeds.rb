# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create(email: "tempadmin@wici.com", approved: true, password: "WICIWebsite", password_confirmation: "WICIWebsite")
Leader.create(firstname: "Kiera", lastname: "Wilhelm", role: "President")
