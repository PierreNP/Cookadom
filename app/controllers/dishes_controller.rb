class DishesController < ApplicationController
  before_action :set_dish, only: %i[show edit update destroy]
  
  def index
    @dishes = Dish.all
  end

  def show;end

  def new
    @dish = Dish.new
  end

  def create
    @dish = Dish.new(dish_params)

    if @dish.save 
      redirect_to @dish, flash[:succes] = "Nouveau plat ajouté !"
    else
      render :new, flash[:error] = "Erreur, impossible d'ajouter le palt'"
    end
  end

  def edit;end

  def update
    if @dish.update
      redirect_to @dish, flash[:succes] = "Nouveau plat ajouté !"
    else
      render :edit, flash[:error] = "Erreur : Impossible de modifier le plat."
    end
  end

  def destroy
    @dish.destroy
    redirect_to root_path, flash[:succes] = "Plat supprimée"
  end

  private 
    
  def set_dish
    @dish = dish.find_by(params[:id])

  end

  def dish_params
    params.require(:dish).permit(:name, :description, :price, :ingredients, :cook_id)
    
  end

end
