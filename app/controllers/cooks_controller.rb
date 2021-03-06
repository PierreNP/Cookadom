class CooksController < ApplicationController

  before_action :authenticate_user!
  before_action :set_cook, only: [:show, :edit, :update, :destroy]
 
  def show
    @dishes = @cook.dishes
    @addresses = @cook.user.addresses
    @cook_votes = @cook.count_cook_total_number_of_votes
    @pinned_dish = @dishes.find_by(status:"pinned") 
  end

  def new
    redirect_to root_path if current_user.cook
    @cooks = Cook.new
  end

  def create
    
    @cook = Cook.new(cook_params)
    @cook.user_id = current_user.id

    if @cook.save
      puts "Profil de Cook mis à jour."
      redirect_to root_path
    else
      puts @cook.errors.messages
      puts "Profil de Cook non mis à jour."
      render new_cook_path
    end
  end

  def edit
  end

  def update
    @cook.update(cook_params)
  end

  def destroy
    if @cook.destroy
      flash[:succes] = "Détruit avec succès"
    else
      flash[:error] = "Une erreur est survenue"
    end
    respond_to do |format|
      format.html {redirect_to root_path}
      format.js {}
    end
  end

  private 
  
  def cook_params
    return params.require(:cook).permit(:user_id, :siren, :business_name, :legal_status, :headquarter, :vat_number, :commercial_register, :avatars)
  end

  def set_cook
    @cook = Cook.find_by(id: params[:id])
  end

end
