class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)

    if @comment.save
      flash[:success] = "Le commentaire a bien été ajouté !"
      redirect_back(fallback_location: root_path)
    else
      flash[:error] = "#{ @comment.errors.messages }"
    end
  end

  def destroy
    @comment = Comment.find_by(comment_params)
    if @comment.destroy
      flash[:success] = "Le commentaire a bien été supprimé !"
    else
      flash[:error] = "Impossible de supprimer le commentaire."
    end
  end

  def update
    @comment = Comment.find_by(user_id: params[:user_id], dish_id: params[:dish_id])

    if @comment.update(comment_params)
      flash[:success] = "Le commentaire a bien été mis à jour !"
    else
      flash[:error] = "#{ @comment.errors.messages }"
    end
  end

  private

  def comment_params
    {:user_id => current_user.id, :dish_id => params[:format], :content => params[:comment][:content]}
  end 
end
