class CooksController < ApplicationController
  before_action :set_cook, only: [:show, :edit, :update, :destroy]
 
##########################
  def new
  end
##########################
  def create

    @cook = Cook.new(cook_params, status: false)

    if @cook.save
      puts "cook saved"
    else
      puts @cook.errors.messages
      puts "cook not saved"
      redirect_to new_cook_path
    end

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

    @status = @cook.status

    if @cook.update(cook_params)
      puts "cook updated"
    else
      puts @cook.errors.messages
      puts "cook not updated"
      redirect_to edit_cook_path(@cook)
    end

    if @cook.status != @status
      CookMailer.answer_admin(@cook)
    end
    
    respond_to do |format|
      format.html {redirect_to cook_path(@cook)}
      format.js {}
    end

  end
##########################
  def destroy

    @cook.destroy

    respond_to do |format|
      format.html {redirect_to root_path}
      format.js {}
    end
  end
##########################
##########################
  private 

##########################  
  def cook_params
    return params.permit(:user_id, :siren, :business_name, :legal_status, :headquarter, :vat_number, :commercial_register)
  end
##########################
  def set_cook
    @cook = Cook.find_by(id: params[:id])
  end
##########################
end
