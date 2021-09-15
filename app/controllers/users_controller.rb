class UsersController < ApplicationController

  before_action :authenticate_user!

    def show
      @past_carts = Cart.where(user_id: current_user.id, status: 2)

      respond_to do |format|
        format.html {}
        format.js {}
      end
    end
  
    def edit
      @address = Address.new
    end
  
    def update
      current_user.update(user_params)
  
      respond_to do |format|
        format.html {redirect_to user_path(current_user.id)}
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

    def autocomplete
      if params["q"].size > 2
       result = search_adresse(params["q"])
       found = result if result.present?
         render :json => found
      else
         render :json => ['no']
      end
    end
      
    private
   
    def user_params
      return params.permit(:first_name, :last_name, :phone, :city_id, :name)
    end
end
