class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)

    if @comment.save
      flash[:success] = "Le commentaire a bien été ajouté !"
    else
      flash[:error] = "#{ @comment.errors.messages }"
    end
  end

  def destroy
    @comment = Comment.find_by(comment_params)

    if @comment.destroy
      flash[:success] = "Le commentaire a bien été supprimé !"
    else
      flash[:error] = "Impossible de supprimé le commentaire"
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
    params.require(:comment).permit(:user_id, :dish_id, :content)
  end
end
