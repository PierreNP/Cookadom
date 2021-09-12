class RatingsController < ApplicationController

  def create
    if Rating.find_by(user_id: current_user.id, dish_id: params[:dish_id])
      flash[:error] = "Désolé vous avez déà noté ce plat"
    else
      if Rating.create(user_id: current_user.id, dish_id: params[:dish_id], value: params[:value])
        flash[:success] = "Merci de votre avis !"
      else 
        flash[:error] = "Impossible de noter le plat pour le moment"
      end
    end
    redirect_back(fallback_location: root_path)
  end

end

