class Cart < ApplicationRecord
  enum status: [ :pre_validation, :validation, :post_validation ]

  belongs_to :user, optional: true

  has_many :order_dishes
  has_many :dishes, through: :order_dishes

  validates :status, presence: true

  def total_price
    total = 0
    self.order_dishes.each do |order|
       total += (order.dish.price.to_d * order.quantity)
    end
    total
  end
end
