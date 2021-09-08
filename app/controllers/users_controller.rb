class UsersController < ApplicationController
    def show
        if !current_user.is_cook?
            @user = User.find(params[:id])
            @user_dishes = Dish.where(cook_id:@user.id)
        else 
            @user = current_user
    end
  
    def edit
      @user = User.new
    end
  
    def update
      @user = current_user
      @user.update(user_params)
      edit_profile_send(@user)
  
      respond_to do |format|
        format.html {redirect_to user_path(@user.slug)}
        format.js {}
      end
    end
  
    def destroy
      @cart.destroy
      current_user.destroy
  
      respond_to do |format|
        format.html {redirect_to root_path}
        format.js {}
      end
    end
  
    private
  
    def edit_profile_send(user)
      UserMailer.edit_profile_email(user).deliver_now
    end
  
    def user_params
      return params.permit(:first_name, :last_name, :address, :email)
    end 
end
