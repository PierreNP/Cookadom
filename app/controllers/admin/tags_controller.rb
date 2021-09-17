class Admin::TagsController < ApplicationController

  before_action :authenticate_user!
  before_action :require_admin
  before_action :set_tag, only: [:update, :destroy]

  def create
    @tag = Tag.create(tag_params)
    respond_to do |format|
      format.html {redirect_to admin_dashboard_admins_path}
      format.js {}
    end
  end

  def update
    @tag.update(tag_params)
    
    respond_to do |format|
      format.html {redirect_to admin_dashboard_admins_path}
      format.js {}
    end
  end

  def destroy
    if @tag
      @tag.destroy

      respond_to do |format|
        format.html {redirect_to admin_dashboard_admins_path}
        format.js {}
      end
    end
    flash[:error] = "Une erreur est survenue"
  end

  def require_admin
    unless current_user.admin?
      redirect_to root_path
    end
  end

  private

  def set_tag
    @tag = Tag.find_by(id: params[:id])
  end

  def tag_params
    params.require(:tag).permit(:label)
  end

end
