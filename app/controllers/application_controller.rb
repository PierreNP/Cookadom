class ApplicationController < ActionController::Base

  include CartsHelper
  
  before_action :current_cart

  def after_sign_in_path_for(resource)
    dishes_path
  end
end
