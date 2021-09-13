class Rating < ApplicationRecord

   belongs_to :user
   belongs_to :dish

   validates :value, presence: true, numericality: { only_integer: true, greater_than: 0, less_than: 6 }

end
