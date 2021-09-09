class Admin::CooksController < ApplicationController
  
  before_action :authenticate_user!
  before_action :require_admin
  before_action :set_cook, only: [:update, :destroy]
 

  def index
    @valid_cooks = Cook.where(status: true)
    @invalid_cooks = Cook.where(status: false)
    @cooks = Cook.all
  end

  def update
    @status = @cook.status

    if @status == true
      @cook.update(status: false)
    else
      @cook.update(status: true)
    end

    if @cook.status != @status && @cook.status == true
      CookMailer.answer_admin(@cook)
    end
    
    respond_to do |format|
      format.html {redirect_to admin_cooks_path}
      format.js {}
    end
  end

  def destroy
    @cook.destroy

    respond_to do |format|
      format.html {redirect_to admin_cooks_path}
      format.js {}
    end
  end

  def require_admin
    unless current_user.admin?
      redirect_to root_path
    end
  end


  private 

  
  def cook_params
    return params.permit(:user_id, :siren, :business_name, :legal_status, :headquarter, :vat_number, :commercial_register, :status)
  end

  def set_cook
    @cook = Cook.find_by(id: params[:id])
  end

end
