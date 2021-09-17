class Admin::AdminDishesController < ApplicationController

  before_action :authenticate_user!
  before_action :require_admin
  before_action :set_dish, only: [:destroy]

  def destroy
    if @dish
      @dish.destroy

      respond_to do |format|
        format.html {redirect_to admin_dashboard_admins_path}
        format.js {}
      end
    end
    flash [:error] = "Une erreur est survenue"
  end

  def require_admin
    unless current_user.admin?
      redirect_to root_path
    end
  end

  private

  def set_dish
    @dish = Dish.find_by(id: params[:id])
  end
end
