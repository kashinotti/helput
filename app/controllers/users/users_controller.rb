class Users::UsersController < ApplicationController


  def show
    @user = User.find(params[:id])
    @posts = @user.posts
    @likes = Like.where(user_id: @user.id)
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
