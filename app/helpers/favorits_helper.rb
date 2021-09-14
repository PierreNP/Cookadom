module FavoritsHelper
  def favorit_dish_to_destroy(dish)
    current_user.favorit_dishes.find_by(favorit_dish_id: dish.id)
  end
end
