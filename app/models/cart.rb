class Cart < ApplicationRecord
  enum status: [ :pre_validation, :validation, :post_validation ]

belongs_to :user
has_many :order_dishes
has_many :dishes, through: :order_dishes

end
