class AddressesController < ApplicationController
  def create 
    @address = Address.new()
    @address.name = params[:address][:name]
    @address.content = address_hasher(params[:address][:name_select])
    @address.user_id = current_user.id
    @address.additional_info = params[:address][:additional_info]
    if @address.save
      flash[:success]="Une nouvelle adresse a bien été ajoutée."
    else
      flash[:error] = @address.errors.messages
    end
    
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

  def address_hasher(label)
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

    return content
  end
end



