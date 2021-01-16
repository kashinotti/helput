class Users::PostsController < ApplicationController
  before_action :authenticate_user!
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params.merge({user_id: current_user.id}))
    if @post.save
      redirect_to post_path(@post.id)
    else
      render :new
    end
  end

  def index
    @user = User.find(current_user.id)
    # ransackの投稿内容の検索結果を表示するための変数を定義
    @q = Post.ransack(params[:q])
    @posts = @q.result(distinct: true).where(user_id: @user).order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
    @post = Post.find(params[:id])
    @like = @post.likes.find_by(user_id: current_user.id)
    @comments = @post.comments.where(parent_id: nil)
    @comment = @post.comments.new
    @comment_reply = @post.comments.new
    @post.comments.each do |comment|
    end

  end

  def show_like_users
    @post = Post.find(params[:id])
    @likes = Like.where(post_id: @post.id).order(updated_at: :desc).page(params[:page]).per(10)
  end

  def edit
    @post = Post.find(params[:id])
    # 他のユーザーがアクセスしようとしたときに遷移させないために条件分岐
    if @post.user_id != current_user.id
      if user_signed_in?
        redirect_to user_path(current_user.id)
      else
        redirect_to new_user_session_path
      end
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params.merge({user_id: current_user.id}))
      redirect_to post_path(@post.id)
    else
      render :edit
    end
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
