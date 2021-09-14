class Cart < ApplicationRecord
  enum status: [ :pre_validation, :validation, :post_validation, :paid ]

  belongs_to :user, optional: true
  belongs_to :address, optional: true

  has_many :order_dishes
  has_many :dishes, through: :order_dishes

  validates :status, presence: true

  def total_price
    total = 0
    self.order_dishes.each do |order|
       total += (order.dish.price * order.quantity)
    end
    total
  end

  def show_date
    self.delivery_date.strftime("%m/%d/%Y à %I:%M ") if self.delivery_date
  end

  def total_price_euro
    money = Money.from_cents(self.total_price, "EUR").format
    currency = money.slice!(0)
    money.insert(-1, " #{currency}")
  end


  def clean_and_destroy_cart
    user_id = self.user_id
    user = User.find(user_id)
    self.order_dishes.each do |order_dish|
      order_dish.destroy
    end
    self.destroy
    Cart.create(user_id: user_id, status: "pre_validation") unless user.carts.find_by(status: "pre_validation")
  end
end
