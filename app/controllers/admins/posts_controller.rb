class Admins::PostsController < ApplicationController

  def index
    @posts = Post.all.order(created_at: :desc)
     # ransackの投稿内容の検索結果を表示するための変数を定義
    @q = @posts.ransack(params[:q])
    @search_posts = @q.result(distinct: true)
  end

  def search_index
    # ransackの投稿内容の検索結果を表示するための変数を定義
     @q = Post.ransack(params[:q])
     # byebug
     @posts = @q.result(distinct: true)
  end
  
  def show
    @post = Post.find(params[:id])
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      redirect_to admins_posts_path
      flash[:notice] = "投稿を削除しました。"
    else
      render :show
    end
  end

end
