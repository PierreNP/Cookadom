class Admin::UsersController < ApplicationController

  before_action :authenticate_user!
  before_action :require_admin
  before_action :set_user, only: [:update, :destroy]

 
    def index
      @users = User.user
    end
  
    def update
      @user.update(user_params)
  
      respond_to do |format|
        format.html {redirect_to admin_users_path}
        format.js {}
      end
    end
 
    def destroy
      @cart.destroy
      @user.destroy
      
      respond_to do |format|
        format.html {redirect_to admin_users_path}
        format.js {}
      end
    end

  def require_admin
    unless current_user.admin?
      redirect_to root_path
    end
  end

  
    private

    
    def user_params
      return params.permit(:first_name, :last_name, :status, :phone, :city_id)
    end 
    
    def set_user
      return @user = User.find_by(id: params[:id])
    end     

end
