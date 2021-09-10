class AddressesController < ApplicationController

  def create 
    current_user.addresses.each do |a|
      a.destroy
    end
    
    @address = Address.new(address_params)
    @address.user_id=current_user.id
    @address.save
    
      redirect_to dishes_path

  end

  private

  def address_params
    params.require(:address).permit!
  end


end
