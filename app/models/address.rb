class Address < ApplicationRecord
   
   belongs_to :user
   belongs_to :city
   has_many :carts

   validates :name, presence: true, length: { in: 4..200 }
   validates :content, presence: true
   validates :additional_info, length: { in: 0..200 }

   def full
      content + additional_info
   end


end
