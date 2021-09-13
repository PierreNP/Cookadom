class Comment < ApplicationRecord
   belongs_to :user
   belongs_to :dish
   
   validates :comment, presence: true, length: { in: 5..250 }
end
