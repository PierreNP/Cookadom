class ApplicationController < ActionController::Base

  include CartsHelper
  
  before_action :current_cart

end
