class Comment < ApplicationRecord

   belongs_to :sender, class_name: "User"
   belongs_to :recipient, class_name: "User"
   
   validates :comment, presence: true, length: { in: 5..250 }
end
