class DishesController < ApplicationController


  def index
    @dishes = Dish.where(availability: true)
  end

  def show
    @dish = Dish.find(params[:id])
    @comments = Comment.new
  end
 
end
