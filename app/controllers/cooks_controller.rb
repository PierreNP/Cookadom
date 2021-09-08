class CooksController < ApplicationController
  before_action :set_cook, only: [:show, :edit, :update, :destroy]

##########################
  def new
  end
##########################
  def create

    respond_to do |format|
      format.html {redirect_to root_path}
      format.js {}
    end
  end
##########################
  def show
    @dishes = @cook.dishes
  end
##########################
  def edit
  end
##########################
  def update

    respond_to do |format|
      format.html {redirect_to cook_path(@cook)}
      format.js {}
    end
  end
##########################
  def destroy

    respond_to do |format|
      format.html {redirect_to root_path}
      format.js {}
    end
  end
##########################
##########################
  private 

##########################  
  def cooks_params
    return params.permit(:user_id, :siren, :business_name, :legal_status, :headquarter, :vat_number, :commercial_register)
  end
##########################
  def set_cook
    @cook = Cook.find_by(id: params[:id])
  end
##########################
end
