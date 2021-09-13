class FavoritsController < ApplicationController
  def index
    @favorit_dishes = current_user.favorit_dishes
    if @favorit_dishes.empty?
      redirect_back(fallback_location: root_path)
      flash[:error] = "Vous n'avez pas encore de plat favoris."
    end
  end
end
