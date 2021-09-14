class FavoritsController < ApplicationController
  def index
    @favorit_dishes = current_user.favorit_dishes
    if @favorit_dishes.empty?
      redirect_back(fallback_location: root_path)
      flash[:error] = "Vous n'avez pas de plat favoris."
    end
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
    puts "%"*500
    puts @favorit
    puts current_user.id
    puts params[:dish_id]
    puts "%"*500

    @favorit.destroy
    redirect_back(fallback_location: root_path)
  end
end
