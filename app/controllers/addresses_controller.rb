class AddressesController < ApplicationController

  def create 
    @address = Address.new(address_params)
    @address.user_id = current_user.id
    @address.save
    
    redirect_back(fallback_location: root_path)
  end

  def update
    @address = Address.find(params[:id])

    if @address.update(address_params)
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @address = Address.find(params[:id])
    if @address.destroy
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def address_params
    params.require(:address).permit!
  end
end
