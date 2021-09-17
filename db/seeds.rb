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
 cook = User.create(email: "cook@ex.ex", password: "password", status: 1, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name , city_id: rand(1..20), phone: "0#{rand(600000000..699999999)}")
 Cook.create(user_id: cook.id, siren: "#{rand(100000000..999999999)}", business_name: Faker::Restaurant.name, legal_status: ["EI", "EURL", "SNC", "SCA","SARL","SA", "SAS"].sample, headquarter: Faker::Address.street_name, vat_number: "FR#{rand(100000000..999999999)}", commercial_register: "RCS PARIS #{["A", "B"].sample} #{rand(100000000..999999999)}", status: true)

