class Dish < ApplicationRecord
   validates :name, presence: true, length: { in: 2..40 }
   validates :description, presence: true, length: { in: 2..400 }
   validates :price, presence: true
   validates :ingredients, presence: true

   belongs_to :cook

   has_many :tag_dishes
   has_many :tags, through: :tag_dishes
   has_many :ratings
   has_many :users, through: :ratings
   has_many :order_dishes
   has_many :carts, through: :order_dishes
   
end
