class StaticPagesController < ApplicationController
  def home
    @dishes = Dish.pinned.last(4)
  end

  def home_cook
  end
end
