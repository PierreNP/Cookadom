class RegistrationsController < Devise::RegistrationsController

  def create
    super
    @cart = Cart.new(user_id: current_user.id, status: 0)
    if @cart.save
      flash[:success] = "cart created and attached to user"
      redirect_to dishes_path
    else
      flash[:error] = "cart not created with user"
      render :new
    end
  end

end
