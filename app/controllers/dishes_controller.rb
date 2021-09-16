class DishesController < ApplicationController

  before_action :set_dish, only: [:show]

  def index
    if current_user && @cart.dishes.any?
      @dishes = @cart.cook.dishes
    else
      @dishes_cities = Dish.all_cities
      if params[:city_id]
        @dishes = City.find_by(id: params[:city_id]).dishes_in_a_city
      elsif params[:search]
        @dishes = Dish.target(params[:search])
      elsif current_user && Address.find_by(user_id: current_user.id)
        @dishes = City.find_by(id: current_user.city_id).dishes_in_a_city
      else
        @dishes = Dish.all.where(status: "available")
      end
    end
  end

  def show
    @comment = Comment.new
    @cook = @dish.cook
    @cook_votes = @cook.count_cook_total_number_of_votes

  end

  def set_dish
    @dish = Dish.find(params[:id])
  end
end

