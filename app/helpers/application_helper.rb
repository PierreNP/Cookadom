module ApplicationHelper
  def availability?
    dish.availability 
  end

  def is_a_favorit_dish?(dish)
    if current_user.favorit_dishes.empty?
      return false
    elsif current_user.favorit_dishes.find_by(favorit_dish_id: dish.id)
      return true
    else
      return false
    end
  end
end
