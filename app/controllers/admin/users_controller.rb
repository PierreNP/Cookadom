class Admin::UsersController < ApplicationController

  before_action :authenticate_user!
  before_action :require_admin
  before_action :set_user, only: [:update, :destroy]

 
    def update
      @user.update(status: 3)
  
      respond_to do |format|
        format.html {redirect_to admin_dashboard_admins_path}
        format.js {}
      end
    end
 
    def destroy
      @cart.destroy
      @user.destroy
      
      respond_to do |format|
        format.html {redirect_to admin_dashboard_admins_path}
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
      return params.permit(:status)
    end 
    
    def set_user
      return @user = User.find_by(id: params[:id])
    end     

end
