class Cook::CartsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_cart, only: [:update]

  def update
    @cook = Cook.find_by(user_id: current_user.id)
    @user = User.find_by(id: @cart.user_id)
    @pre_status = @cart.status

    if @cart.update(status: 2)
      flash[:success] = "cart updated"
    else
      puts @cart.errors.messages
      redirect_to root_path, flash[:error] = "cart not updated"
    end

    UserMailer.validated_order(@user, @cook).deliver_now

    respond_to do |format|
      format.html {redirect_to cook_dishes_path}
      format.js {}
    end
  end

  private

  def set_cart
    @cart = Cart.find_by(id: params[:id])
  end

end
