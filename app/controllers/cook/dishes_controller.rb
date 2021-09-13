class Cook::DishesController < ApplicationController

  before_action :authenticate_user!
  before_action :require_cook
  before_action :set_cook
  before_action :set_dish, only: %i[update destroy]
  
  def index
    @dish = Dish.new()
    @dishes = Dish.where(cook_id: @cook.id)
    @carts = []

    @dishes.each do |dish|
      @order_dishes = OrderDish.where(dish_id: dish.id)
      @order_dishes.each do |order_dish|
        @carts.push(Cart.find_by(id: order_dish.cart_id)) unless @carts.include?(Cart.find_by(id: order_dish.cart_id))
      end
    end
  end

  def create
    @dish = Dish.new(dish_params)
    @dish.cook_id = @cook.id
    if @dish.save 
      redirect_to cook_dishes_path, success:  "Nouveau plat ajouté !"
    else
      render cook_dishes_path, error: "Impossible d'ajouter le plat"
    end
  end

  def update
    @dish.cook_id = @cook.id
 
    if params[:dish][:status] == "pinned" && Dish.where(status: "pinned").any?
        flash[:error] = "Vous ne pouvez pas avoir plusieur plat épinglés."
    elsif @dish.update(dish_params)
      flash[:success] = "Nouveau plat ajouté !"
    else
      flash[:error] = "Impossible de modifier le plat."
    end
    redirect_to cook_dishes_path
  end

  def destroy
    @dish.destroy
    redirect_to cook_dishes_path, success: "Plat supprimé."
  end

  def require_cook
    redirect_to root_path unless Cook.find_by(user_id: current_user.id)
  end  

  private 
  
  def set_dish
    @dish = Dish.find_by(id: params[:id])
  end
  
  def set_cook
    @cook = Cook.find_by(user_id: current_user.id)
  end

  def dish_params
    params.require(:dish).permit(:name, :description, :price, :ingredients, :status)
  end

end
