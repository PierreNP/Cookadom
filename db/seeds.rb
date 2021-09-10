# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'activerecord-reset-pk-sequence'
require 'faker'

OrderDish.destroy_all
OrderDish.reset_pk_sequence

Cart.destroy_all
Cart.reset_pk_sequence

Rating.destroy_all
Rating.reset_pk_sequence

TagDish.destroy_all
TagDish.reset_pk_sequence

Dish.destroy_all
Dish.reset_pk_sequence

Comment.destroy_all
Comment.reset_pk_sequence

Address.destroy_all
Address.reset_pk_sequence

Cook.destroy_all
Cook.reset_pk_sequence

User.destroy_all
User.reset_pk_sequence

Tag.destroy_all
Tag.reset_pk_sequence

City.destroy_all
City.reset_pk_sequence


20.times do 
  City.create(name: Faker::Address.city, zip_code: Faker::Address.zip_code)
end
puts "City create"

20.times do 
  Tag.create(label: Faker::Food.ethnic_category)
end
puts "Tag create"

20.times do 
  user = User.create(email: Faker::Internet.safe_email, password: "password", status: rand(0..2), first_name: Faker::Name.first_name, last_name: Faker::Name.last_name , city_id: rand(1..20), phone: "0#{rand(600000000..699999999)}")
  puts user.errors.messages
  if user.status == "cook"
    Cook.create(user_id: user.id, siren: "#{rand(100000000..999999999)}", business_name: Faker::Restaurant.name, legal_status: ["EI", "EURL", "SNC", "SCA","SARL","SA", "SAS"].sample, headquarter: Faker::Address.street_name, vat_number: "FR#{rand(100000000..999999999)}", commercial_register: "RCS PARIS #{["A", "B"].sample} #{rand(100000000..999999999)}", status: false)
    puts "Cook create"
  end
  Address.create(name: ["home","friend 1", "work", "friend 2", "mummy the best mom"].sample, street_name: Faker::Address.street_name,street_number: rand(1..80), street_type: "rue", additional_info: "blabla", user_id: user.id)
  puts "Address create"
  Cart.create(stripe_customer_id: rand(100000000..999999999).to_s, status: rand(0..2), user_id: user.id)
  puts "Cart create"
end
puts "User create"



20.times do 
  Comment.create(comment: Faker::Lorem.sentence(word_count: rand(1..10)), sender_id: rand(1..10), recipient_id: rand(1..10))
end
puts "Comment create"

20.times do 
  Dish.create(name: Faker::Food.dish.to_s, description: Faker::Lorem.sentence(word_count: rand(1..10)).to_s, price: rand(5..20), ingredients: Faker::Food.description.to_s, cook_id: rand(1..Cook.all.length))
end
puts "Dish create"

25.times do 
  TagDish.create(tag_id: rand(1..20), dish_id: rand(1..20))
end
puts "TagDish create"

15.times do 
  Rating.create(rate: rand(1..5), user_id: rand(1..20), dish_id: rand(1..20))
end
puts "Rating create"


15.times do 
  OrderDish.create(quantity: rand(1..3).to_s, cart_id: rand(1..15), dish_id: rand(1..20))
end
puts "OrderDish create"

