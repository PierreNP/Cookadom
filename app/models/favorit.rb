class Favorit < ApplicationRecord
  belongs_to :favorit_user, class_name: "User"
  belongs_to :favorit_dish, class_name: "Dish"
end