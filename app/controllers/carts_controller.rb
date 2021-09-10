class CartsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_cart, only: [:show, :update]

  def show
  end

  def update
    @order_dish = OrderDish.find_by(cart_id: @cart.id)
    @dish = Dish.find_by(id: @order_dish.dish_id)
    @cook = Cook.find_by(id: @dish.cook_id)
    @user = User.find_by(id: @cart.user_id)
    @pre_status = @cart.status

    if @cart.update(status: 1)
      flash[:success] = "cart updated"
    else
      puts @cart.errors.messages
      redirect_to root_path, flash[:error] = "cart not updated"
    end

    UserMailer.waiting_for_validation(@user).deliver_now
    CookMailer.cooking_to_do(@cook).deliver_now


    respond_to do |format|
      format.html {}
      format.js {}
    end
  end

  private

  def set_cart
    @cart = Cart.find_by(id: params[:id])
  end

end
