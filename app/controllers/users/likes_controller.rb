class Users::LikesController < ApplicationController
  before_action :set_like, only: [:create, :destroy]

  def create
    @like = current_user.likes.new(post_id: @post.id)
    @like.save
  end

  def destroy
    @like = current_user.likes.find_by(post_id: @post.id, id: params[:id])
    @like.destroy
  end
  
  private
  
  def set_like
    @post = Post.find(params[:post_id])
  end
  
end
