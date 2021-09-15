module CartsHelper

  def current_cart
    if current_user      
      @cart = current_user.carts.last
    end
  end

  def user_addresses
    @user_addresses = []
    current_user.addresses.each do |address|
      @user_addresses << [address.name, address.id]
    end
    return @user_addresses
  end
end
