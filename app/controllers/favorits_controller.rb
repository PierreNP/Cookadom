class FavoritsController < ApplicationController
  def index
    @favorits = current_user.favorit_dishes
  end

  def create
    @new_favorit = Favorit.new(favorit_user_id: current_user.id, favorit_dish_id: params[:dish_id])
    if @new_favorit.save
      redirect_back(fallback_location: root_path)
      flash[:success] = "Plat ajouté à votre liste de Favoris."
    else 
      flash[:error] = "Impossible de rajouter ce plat à vos Favoris."
    end
  end

  def destroy
    @favorit = Favorit.find_by(favorit_user_id: current_user.id, favorit_dish_id: params[:id])
    if @favorit
      if @favorit.destroy
      redirect_back(fallback_location: root_path)
      end
    end
    flash [:error] = "Une erreur est survenue"
  end
end
