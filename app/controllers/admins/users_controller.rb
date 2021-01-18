class Admins::UsersController < ApplicationController
  layout 'admins'
  before_action :authenticate_admin!
  before_action :set_user, only: [:show, :update, :follow_index, :follower_index]

  def index
    @users = User.all.order(updated_at: :desc).page(params[:page]).per(10)
    @q = @users.ransack(params[:q])
    @search_uesrs = @q.result(distinct: true)
  end

  def search_user_index
    # ransackのユーザーの検索結果を表示するための変数を定義
     @q = User.ransack(params[:q])
     @users = @q.result(distinct: true).order(created_at: :desc).order(updated_at: :desc).page(params[:page]).per(10)
  end

  def show
    @posts = @user.posts.order(updated_at: :desc).page(params[:page]).per(10)
  end

  def follow_index
    @followings = @user.followings.all.order(created_at: :desc).page(params[:page]).per(10)
  end

  def follower_index
    @followers = @user.followers.all.order(created_at: :desc).page(params[:page]).per(10)
  end

  def update
    @user.update(user_params)
    # 退会フラグtrue変更後にユーザーの投稿、いいね、コメントを全て削除し、他のユーザーに表示されないようにする
    if @user.is_deleted == true
      @user.posts.destroy_all
      @user.likes.destroy_all
      @user.comments.destroy_all
      redirect_to admins_user_path(@user.id)
    else
      redirect_to admins_user_path(@user.id)
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:is_deleted)
  end

end
