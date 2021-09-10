class Cart < ApplicationRecord
  enum status: [ :pre_validation, :validation, :post_validation, :paid ]

  belongs_to :user, optional: true

  has_many :order_dishes
  has_many :dishes, through: :order_dishes

  validates :status, presence: true

  def total_price
    total = 0
    self.order_dishes.each do |order|
       total += (order.dish.price * order.quantity * 100)
    end
    total
  end

  def clean_and_destroy_cart
    user_id = self.user_id
    self.order_dishes.each do |order_dish|
      order_dish.destroy
    end
    self.destroy
    Cart.create(user_id: user_id, status: "pre_validation")
  end
end
