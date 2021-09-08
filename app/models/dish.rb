class Dish < ApplicationRecord
 
   belongs_to :cook

   has_many :tag_dishes
   has_many :tags, through: :tag_dishes
   has_many :ratings
   has_many :users, through: :ratings
   has_many :order_dishes
   has_many :carts, through: :order_dishes
 
   validates :name, presence: true, length: { in: 2..40 }
   validates :description, presence: true, length: { in: 2..400 }
   validates :price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
   validates :ingredients, presence: true, length: { in: 5..1000 }

end
