class CartsController < ApplicationController
  before_action :set_cart, only: [:update, :destroy]
##########################
  def create

    @cart = Cart.new(user_id: current_user, status: 0)

    if @cart.save
      puts "cart saved"
    else
      puts @cook.errors.messages
      puts "cart not saved"
      redirect_to root_path
    end

  end
##########################
  def update
    @order_dish = OrderDish.find_by(cart_id: @cart.id)
    @dish = Dish.find_by(id: @order_dish.id)
    @cook = Cook.find_by(id: @dish.id)
    @user = @cart.user_id

    if @cart.update(cart_params)
      puts "cart updated"
    else
      puts @cart.errors.messages
      puts "cart not updated"
      redirect_to root_path
    end

    if @cart.status == 1
      UserMailer.waiting_for_validation(@user).deliver_now
    elsif @cart.status == 2
      UserMailer.validated_order(@user, @cook).deliver_now
    else
    end

    respond_to do |format|
      format.html {}
      format.js {}
    end

  end
##########################
  def destroy

    @cart.destroy

    respond_to do |format|
      format.html {redirect_to root_path}
      format.js {}
    end

  end
##########################
##########################
  private

##########################
  def set_cart
    @cart = Cart.find_by(id: params[:id])
  end
##########################
  def cart_params
    params.permit(:status, :stripe_customer_id)
  end
##########################
end
