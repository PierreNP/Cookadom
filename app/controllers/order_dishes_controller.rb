class OrderDishesController < ApplicationController
  def create
    order = OrderDish.new(dish_id: params[:dish_id], cart_id: @cart.id, quantity: 1)
    
    if order.save
      flash[:sucess] = "Plat ajouté au panier"
    else
      flash[:error] = "Impossible d'ajouter la plat au panier"  
    end
    redirect_to dishes_path
  end
end
