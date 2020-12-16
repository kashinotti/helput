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
    # 12/13現在、まだマイページを作成できていないので、とりあえず新規投稿画面へリダイレクト
    redirect_to new_post_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end

end
