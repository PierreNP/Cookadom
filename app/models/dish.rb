class Dish < ApplicationRecord

   belongs_to :cook

   has_many :tag_dishes
   has_many :tags, through: :tag_dishes
   has_many :ratings
   has_many :users, through: :ratings
   has_many :order_dishes
   has_many :carts, through: :order_dishes

end
