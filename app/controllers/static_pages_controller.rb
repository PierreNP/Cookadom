class StaticPagesController < ApplicationController
  def home
    @dishes = Dish.last(4)
  end

  def home_cook
  end
end
