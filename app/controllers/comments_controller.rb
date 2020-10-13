class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to item_path(@comment.item.id)
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      redirect_to item_path(@comment.item.id)
  end

  private

  def comment_params
    params.require(:comment).permit(:comment, :item_id).merge(user_id: current_user.id)
  end

end
