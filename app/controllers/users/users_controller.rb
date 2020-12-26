class Users::UsersController < ApplicationController


  def show
    @user = User.find(params[:id])
    # 投稿一覧・タイムライン(自分とフォローユーザーの投稿を表示)いいねした投稿を表示するための変数を定義
    @posts = @user.posts
    @likes = Like.where(user_id: @user.id)
    @timelines = Post.where(user_id: [@user.id, @user.followings.ids].flatten).order(created_at: :desc)
    # 検索フォームの値を格納するために@qを定義
    @q = Post.ransack(params[:q])
    
    # チャット機能に必要な変数を以下に記述
    @currentUserRoom = UserRoom.where(user_id: current_user.id)
    @otherUserRoom = UserRoom.where(user_id: @user.id)
    
    unless @user.id == current_user.id
      
      @currentUserRoom.each do |cu|
        @otherUserRoom.each do |ot|
          if cu.room_id == ot.room_id
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end
    end
    
    unless @isRoom
      @room = Room.new
      @userRoom = UserRoom.new
    end
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