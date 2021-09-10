module CartsHelper

  def current_cart
    if current_user      
      @cart = current_user.carts.last
    end
  end

end
