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
      redirect_to @dish, success:  "Nouveau plat ajouté !"
    else
      render :new, error: "Impossible d'ajouter le plat"
    end
  end

  def edit;end

  def update
    if @dish.update(dish_params)
      redirect_to @dish, success: "Nouveau plat ajouté !"
    else
      render :edit, error: "Erreur : Impossible de modifier le plat."
    end
  end

  def destroy
    @dish.destroy
    redirect_to root_path, success: "Plat supprimée"
  end

  private 
    
  def set_dish
    @dish = Dish.find(params[:id])

  end

  def dish_params
    params.require(:dish).permit(:name, :description, :price, :ingredients, :cook_id)
    
  end

end
