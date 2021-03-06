class AvatarsController < ApplicationController
  def create
    @cook = Cook.find_by(id: params[:cook_id])
    @cook.avatar.attach(params[:avatar])
    redirect_to root_path, success: "Avatar créé."
  end

  def destroy
    @avatar = Cook.find_by(id: params[:cook_id]).avatar
    if @avatar.destroy
        redirect_to galleries_path, success: 'Avatar supprimé.'
    else
        render :show, error: 'Erreur, impossible de supprimer l\'avatar'
    end
  end

end
