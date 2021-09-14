class Admin::DashboardAdminsController < ApplicationController

  before_action :authenticate_user!
  before_action :require_admin

  def index
    @valid_cooks = Cook.where(status: true)
    @invalid_cooks = Cook.where(status: false)
    @cooks = Cook.all
    @users = User.user
    @tags = Tag.all
  end

  def require_admin
    unless current_user.admin?
      redirect_to root_path
    end
  end

end
