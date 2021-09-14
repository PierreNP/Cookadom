class DishesController < ApplicationController

  before_action :set_dish, only: [:show]

  def index
    if current_user && @cart.dishes.any?
      @dishes = @cart.cook.dishes
    else
      @dishes = Dish.search(params[:search]).where(status: "available")

    end
  end

  def show
    @comments = Comment.new
    @cook_votes = @dish.cook.count_cook_total_number_of_votes
  end

  def set_dish
    @dish = Dish.find(params[:id])
  end
end

