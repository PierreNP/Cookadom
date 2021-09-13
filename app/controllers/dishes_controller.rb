class DishesController < ApplicationController


  def index
    @dishes = Dish.where.not(status: "disabled")
  end

  def show
    @dish = Dish.find(params[:id])
    @comments = Comment.new
  end
 
end
