class Rating < ApplicationRecord

   belongs_to :user
   belongs_to :dish

   validates :value, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }

end
