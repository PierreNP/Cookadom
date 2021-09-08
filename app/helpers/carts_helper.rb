module CartsHelper

  def current_cart
    if current_user
      @cart = current_user.carts.find_by(status: 0)
    end
  end

end
