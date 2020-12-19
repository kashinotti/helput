class Users::UsersController < ApplicationController


  def show
    @user = User.find(params[:id])
    # 投稿一覧・タイムライン(自分とフォローユーザーの投稿を表示)いいねした投稿を表示するための変数を定義
    @posts = @user.posts
    @likes = Like.where(user_id: @user.id)
    @timelines = Post.where(user_id: [@user.id, @user.followings.ids].flatten).order(created_at: :desc)
    # 検索フォームの値を格納するために@qを定義
    @q = Post.ransack(params[:q])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduce, :profile_image)
  end

end
