class UsersController < ApplicationController

#############################  
    def show
    end
#############################  
    def edit
    end
#############################  
    def update
      current_user.update(user_params)
  
      respond_to do |format|
        format.html {redirect_to user_path(current_user.id)}
        format.js {}
      end
    end
############################# 
    def destroy
      #@cart.destroy
      current_user.destroy
      
      respond_to do |format|
        format.html {redirect_to root_path}
        format.js {}
      end
    end
#############################
#############################  
    private

#############################    
    def user_params
      return params.permit(:first_name, :last_name, :status, :phone, :city_id)
    end 
#############################
end
