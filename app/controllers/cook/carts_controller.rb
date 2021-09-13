class Cook::CartsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_cart, only: [:update, :destroy]

  def update
    @cook = Cook.find_by(user_id: current_user.id)
    @user = User.find_by(id: @cart.user_id)
    @pre_status = @cart.status

    if @cart.update(status: 2)
      flash[:success] = "Panier mis à jour."
    else
      puts @cart.errors.messages
      redirect_to root_path, flash[:error] = "Panier non mis à jour."
    end

    UserMailer.validated_order(@user, @cook).deliver_now

    respond_to do |format|
      format.html {redirect_to cook_dishes_path}
      format.js {}
    end
  end

  def destroy
    @cart.clean_and_destroy_cart
    redirect_to cook_dishes_path
  end

  private

  def set_cart
    @cart = Cart.find_by(id: params[:id])
  end

end
