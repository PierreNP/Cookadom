class FavoritesController < ApplicationController
  def index
    @favorit_dishes = current_user.favorit_dishes
  end
end
