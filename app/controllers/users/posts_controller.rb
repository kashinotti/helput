class Users::PostsController < ApplicationController

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params.merge({user_id: current_user.id}))
    @post.save
    redirect_to post_path(@post.id)
  end

  def index
    @user = User.find(current_user.id)
    # ransackの投稿内容の検索結果を表示するための変数を定義
    @q = Post.ransack(params[:q])
    @posts = @q.result(distinct: true)
  end

  def show
    @post = Post.find(params[:id])
    @like = @post.likes.find_by(user_id: current_user.id)
    @comments = @post.comments.where(parent_id: nil)
    @comment = @post.comments.new
    @comment_reply = @post.comments.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params.merge({user_id: current_user.id}))
    redirect_to post_path(@post.id)
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to user_path(current_user.id)
  end

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end

end
