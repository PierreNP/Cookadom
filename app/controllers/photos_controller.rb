class PhotosController < ApplicationController
  def create
    @dish = Dish.find(params[:dish_id])
    @dish.photo.attach(params[:photo])
    redirect_to root_path, success: "photo créer."
  end

  def destroy
    @photo = Dish.find(params[:dish_id]).photo

    if @photo.destroy
        redirect_to dishes_path, success: 'photo supprimé.'
    else
        render :show, error: 'Erreur, impossible de supprimer l\'photo'
    end

  end
end
