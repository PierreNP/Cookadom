class OrderDishesController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create, :destroy]
  before_action :set_order, only: [:update, :destroy]
  
  def create
    if @cart.dishes.empty? || @cart.cook ==  Dish.find_by(id: params[:dish_id]).cook
      
      if @cart.dishes.include?(Dish.find_by(id: params[:dish_id]))
        @order = OrderDish.find_by(dish_id: params[:dish_id], cart_id: @cart.id)
        
        if @order.update(quantity: @order.quantity + params[:quantity].to_i)
          flash[:success] = "Plat ajouté au panier."
        else 
          flash[:error] = "Impossible d'ajouter le plat au panier."  
        end

      else
        order = OrderDish.create(dish_id: params[:dish_id], cart_id: @cart.id, quantity: params[:quantity].to_i)
        puts order.errors.messages
        if order.save
          flash[:success] = "Plat ajouté au panier."
        else
          flash[:error] = "Impossible d'ajouter le plat au panier."  
        end
      end
    else
      flash[:error] = "Vous ne pouvez pas commander à deux cuisiniers différents dans la même commande."
    end
    respond_to do |format|
      format.html {redirect_to dishes_path}
      format.js{}
    end
  end

  def update 
    @order.update(order_params)
  end

  def destroy 
    if @order.destroy
      flash[:success] = "Plat enlevé du panier avec succès."
    else
      flash[:error] = "Impossible de supprimer le plat."
    end
    respond_to do |format|
      format.html{redirect_back(fallback_location: root_path)}
      format.js{}
    end

  end
  
  private

  def order_params
    params.permit(:quantity, :dish_id, :cart_id)
  end

  def set_order
    @order = OrderDish.find(params[:id])
  end

end
