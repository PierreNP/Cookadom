module DishesHelper
  def can_comment?(user,dish)
    i = 0
    if user
      if !user.carts.where(status: 3).nil?
        user.carts.where(status: 3).each do |cart|
          cart.order_dishes.each do |order_dish|
            i +=1 if order_dish.dish_id == dish.id
          end
        end
      end

      if i > 0 && comments_number(user, dish) < i
        return true
      else
        return false
      end
    else
      return false
    end
  end

  def comments_number(user, dish)
    user.comments.where(user_id: user.id, dish_id: dish.id).count
  end
end