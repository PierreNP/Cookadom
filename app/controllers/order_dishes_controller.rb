class OrderDishesController < ApplicationController
  before_action :set_order, only: [:update, :destroy]
  def create
    if @cart.dishes.include?(Dish.find_by(id: params[:dish_id]))
      @order = OrderDish.find_by(dish_id: params[:dish_id], cart_id: @cart.id)
      @order.update(quantity: @order.quantity+1)
    else
      order = OrderDish.new(dish_id: params[:dish_id], cart_id: @cart.id, quantity: 1)
      
      if order.save
        flash[:sucess] = "Plat ajouté au panier"
      else
        flash[:error] = "Impossible d'ajouter la plat au panier"  
      end
      redirect_to dishes_path
    end
  end

  def update 
    @order.update(order_params)
  end

  def destroy 
    if @order.destroy
      flash[:success] = "Plat enlevée du panier avec succès"
    else
      flash[:error] = "Impossible de supprimé le plat"
    end
  end
  
  private

  def order_params
    params.require(:order_dishes).permit(:quantity, :dish_id, :cart_id)
  end

  def set_order
    @order = OrderDish.find(params[:id])
  end

  def modify_quantity
    if params[:sign] == "plus"
      @cartItem.add_quantity(1)
    else params[:sign] == "minus"
      @cartItem.add_quantity(-1)
    end
  end

end
