class Admins::UsersController < ApplicationController
  layout 'admins'
  before_action :authenticate_user!
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
    @user = User.find(params[:id])
    @posts = @user.posts.order(updated_at: :desc).page(params[:page]).per(10)
  end

  def follow_index
    @user = User.find(params[:id])
    @followings = @user.followings.all.order(created_at: :desc).page(params[:page]).per(10)
  end

  def follower_index
    @user = User.find(params[:id])
    @followers = @user.followers.all.order(created_at: :desc).page(params[:page]).per(10)
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to admins_user_path(@user.id)
  end

  private

  def user_params
    params.require(:user).permit(:is_deleted)
  end

end
