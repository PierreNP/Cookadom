class Admin::AdminCommentsController < ApplicationController

  before_action :authenticate_user!
  before_action :require_admin
  before_action :set_comment, only: [:destroy]

  def destroy
    if @comment
      @comment.destroy

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

  def set_comment
    @comment = Comment.find_by(id: params[:id])
  end
end
