class DishesController < ApplicationController


  def index
    @dishes = Dish.where(availability: true)
  end

  def show
    @dish = Dish.find(params[:id])
  end
 
end
