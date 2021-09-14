class DishesController < ApplicationController

  def index
    if current_user && @cart.dishes.any?
      @dishes = @cart.cook.dishes
    else
      @dishes = Dish.search(params[:search]).where(status: "available")

    end
  end

  def show
    @dish = Dish.find(params[:id])
    @comments = Comment.new
  end
end

