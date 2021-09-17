class ApplicationController < ActionController::Base
  include CartsHelper
  include UsersHelper
  before_action :notification
  before_action :current_cart

  def after_sign_in_path_for(resource)
    edit_user_path(current_user)
  end


end
