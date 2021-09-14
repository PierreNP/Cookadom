class DishesController < ApplicationController


  def index
    dishes = Dish.search(params[:search]).where(status: "available")
    @dishes = Array.new
    dishes.each do |dish|
      @dishes << dish unless dish.cook.status
    end
  end

  def show
    @dish = Dish.find(params[:id])
    @comments = Comment.new
  end
end
