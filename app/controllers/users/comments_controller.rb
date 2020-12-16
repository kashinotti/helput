class Users::CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.new(comment_params)
    @comment.post_id = @post.id
    @comment.save
    redirect_to post_path(@post.id)
  end

  # def show
  #   @comment = Comment.find_by(id: params[:id], post_id: params[:post_id])
  #   @post = Post.find(params[:post_id])
  #   @comment_reply = @post.comment.new
  # end

  # def replies
  #   @post = Post.find(params[:post_id])
  #   @comment = Comment.find(params[:id])
  #   @comment_reply = current_user.comments.new(comment_params)
  #   # @comment_reply.post_id = @post.id
  #   @comment_reply.save
  #   redirect_to post_comment_path(@post.id, @comment.id)
  # end

  def destroy
    @comment = Comment.find_by(id: params[:id], post_id: params[:post_id])
    @comment.destroy
    redirect_to post_path(params[:post_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:comment, :parent_id)
  end



end
