# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'activerecord-reset-pk-sequence'
require 'faker'

 admin = User.create(email: "admin@ex.ex", password: "password", status: 2, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name , city_id: rand(1..20), phone: "0#{rand(600000000..699999999)}")
