class Tag < ApplicationRecord

   has_many :tag_dishes
   has_many :dishes, through: :tag_dishes

   validates :label, presence: true, uniqueness: true, length: { in: 3..15 }
   
end
