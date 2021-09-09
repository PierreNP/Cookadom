class DishesController < ApplicationController
  before_action :set_dish, only: %i[show edit update destroy]
  
  def index
    @dishes = Dish.search(params[:search])
  end

  def show
    @dish = Dish.find(params[:id])
  end

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


  def index
    @dishes = Dish.all
  end

  private 

  def set_dish
    @dish = Dish.find(params[:id])
  end

  def dish_params
    params.require(:dish).permit(:name, :description, :price, :ingredients, :cook_id)
  end
 
end
