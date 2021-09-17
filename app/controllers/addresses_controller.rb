class AddressesController < ApplicationController
  def create 
    address_param = address_hasher(params[:address][:name_select])
    @address = Address.new()
    @address.name = params[:address][:name]
    @address.content = address_param[:content]
    @address.city_id = address_param[:city_id]
    @address.user_id = current_user.id
    @address.additional_info = params[:address][:additional_info]
    if @address.save
      flash[:success]="Une nouvelle adresse a bien été ajoutée."
      redirect_back(fallback_location: root_path)
    else
      flash[:error] = @address.errors.messages
    end
  end

  def update
    @address = Address.find(params[:id])

    if @address.update(address_params)
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @address = Address.find(params[:id])
    if @address
      if @address.destroy
        redirect_back(fallback_location: root_path)
      end
    end
    flash[:error] = "Une erreur est survenue"
  end

  private

  def address_params
    params.require(:address).permit!
  end

  def address_hasher(label)
    unless params[:address][:name] && params[:address][:name_select] && params[:address][:search]
      render edit_user_registration_path, error: "Veuillez compléter tout les champs"
      return
    end
    label_array = label.split(" ")
    i = label_array.length
    zip_index = 0
    zip_code = 0
    
    label_array.length.times do
      i-=1
      if label_array[i].to_i > 0    
        zip_index = i
        zip_code = label_array[i]
        break
      end
    end
    city = label_array[zip_index + 1 .. label_array.length - 1].join(" ")
    content = label_array[ 0 .. zip_index - 1].join(" ")
    
    if !City.find_by(zip_code: zip_code, name: city)
      City.create(name: city, zip_code: zip_code)
    end

    city = City.find_by(zip_code: zip_code, name: city)
    if !city
      flash[:error] = "Une erreur c'est produite. adresse non reconnue."
      redirect_back(fallback_location: root_path)
      return
    else
      current_user.update(city_id: city.id) 
      {content:  content, city_id: city.id}
    end
  end
end



