class Cook::PhotosController < ApplicationController
  
  def create
    @dish = Dish.find(params[:dish_id])
    @dish.photo.attach(params[:photo])
    redirect_to root_path, success: "Photo créée."
  end

  def destroy
    @photo = Dish.find(params[:dish_id]).photo
    if @photo
      if @photo.destroy
          redirect_to dishes_path, success: 'Photo supprimée.'
      else
          render :show, error: 'Erreur, impossible de supprimer la photo'
      end
    end
    flash [:error] = "Une erreur est survenue"
  end

end
