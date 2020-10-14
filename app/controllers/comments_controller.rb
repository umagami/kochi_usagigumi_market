class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    @seller_of_item = User.find(@comment.item.user_id)
    @comment.save
    redirect_to item_path(@comment.item.id)
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      redirect_to item_path(@comment.item.id)
    end
  end

  private

  def comment_params
    params.permit(:message,:item_id).merge(user_id: current_user.id)
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

end
