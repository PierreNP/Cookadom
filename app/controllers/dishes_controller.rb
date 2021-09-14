class DishesController < ApplicationController


  def index
    @dishes = Dish.search(params[:search]).where(status: "available")
  end

  def show
    @dish = Dish.find(params[:id])
    @comments = Comment.new
  end
end
