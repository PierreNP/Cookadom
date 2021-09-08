class Address < ApplicationRecord

   belongs_to :user

   validates :name, presence: true, length: { in: 4..200 }
   validates :street_name, presence: true
   validates :street_number, presence: true, numericality: { only_integer: true }
   validates :street_type, presence: true, inclusion: { in: %w(rue avenue boulevard impasse allée place carrefour chaussée chemin cité clos côte résidence ruelle sentier)}
   validates :additional_info, length: { in: 0..200 }
end
