class Users::CommentsController < ApplicationController
  before_action :set_post, only: [:create, :new_reply, :reply_create]
  
  def create
    @comment = current_user.comments.new(comment_params)
    @comment.post_id = @post.id
    if @comment.save
      redirect_to post_path(@post.id)
    else
      # posts_controllerのshowへrenderするために変数を定義
      @post = Post.find(params[:post_id])
      @like = @post.likes.find_by(user_id: current_user.id)
      @comments = @post.comments.where(parent_id: nil)
      # @post.comments.new
      @comment_reply = @post.comments.new
      render "users/posts/show"
    end
  end

  def new_reply
    @comment = Comment.find_by(post_id: @post.id, id: params[:id])
    @comment_reply = @post.comments.new
  end

  def reply_create
    @comment_reply = current_user.comments.new(comment_params)
    @comment_reply.post_id = @post.id
    if @comment_reply.save
      redirect_to post_path(@post.id)
    else
      @post = Post.find(params[:post_id])
      @comment = Comment.find_by(post_id: @post.id, id: params[:id])
      render "new_reply"
    end
  end


  def destroy
    if @comment = Comment.find_by(id: params[:id], post_id: params[:post_id]).destroy
      redirect_to post_path(params[:post_id])
    else
      redirect_to post_path(params[:post_id])
    end
  end

  private
  
  def set_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:comment, :parent_id)
  end



end
