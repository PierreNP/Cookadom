module FavoritsHelper
  def favorit_dish_to_destroy(dish)
    current_user.favorits.find_by(favorit_dish_id: dish.id)
  end
end
