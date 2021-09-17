class Admin::CooksController < ApplicationController
  
  before_action :authenticate_user!
  before_action :require_admin
  before_action :set_cook, only: [:update, :destroy]

  def update
    @status = @cook.status

    if @status == true
      @cook.update(status: false)
      User.find_by(id: @cook.user_id).update(status: "user")
    else
      @cook.update(status: true)
      User.find_by(id: @cook.user_id).update(status: "cook")
    end

    if @cook.status != @status && @cook.status == true
      CookMailer.answer_admin(@cook)
    end
    
    respond_to do |format|
      format.html {redirect_to admin_dashboard_admins_path}
      format.js {}
    end
  end

  def destroy
    User.find_by(id: @cook.user_id).update(status: "user")
    if @cook
      @cook.destroy

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

  
  def cook_params
    return params.permit(:user_id, :siren, :business_name, :legal_status, :headquarter, :vat_number, :commercial_register, :status)
  end

  def set_cook
    @cook = Cook.find_by(id: params[:id])
  end

end
