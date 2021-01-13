class Users::UsersController < ApplicationController
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
    # 更新順で１０個ごとにページングできるようにorder,perメソッドで設定
    @posts = @user.posts.order(updated_at: :desc).page(params[:page]).per(10)
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
  
  def timeline
    # 新着順で表示できるようにorderメソッドを使用。whereで自分とフォローしているユーザーの投稿を取得
    @timelines = Post.where(user_id: [current_user.id, current_user.followings.ids].flatten).order(created_at: :desc).page(params[:page]).per(10)
  end
  
  def like_post
    @user = User.find(params[:id])
    # 更新順で１０個ごとにページングできるようにorder,perメソッドで設定
    @likes = Like.where(user_id: @user.id).order(updated_at: :desc).page(params[:page]).per(10)
  end

  def edit
    @user = User.find(params[:id])
    # 他のユーザーがアクセスしようとしたときに遷移させないために条件分岐
    if @user.id != current_user.id
      if user_signed_in?
        redirect_to user_path(current_user.id)
      else
        new_user_session_path
      end
    end
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end
  
  def follow_index
    @user = User.find(params[:id])
    @followings = @user.followings.all.order(created_at: :desc).page(params[:page]).per(10)
  end
  
  
  def follower_index
    @user = User.find(params[:id])
    @followers = @user.followers.all.order(created_at: :desc).page(params[:page]).per(10)
  end
  
  def unsubscribe
    @user = User.find_by(id: current_user.id)
  end
  
  def withdraw
    @user = User.find(params[:id])
    # is_deletedカラムをtrueにする
    @user.update(is_deleted: true)
    # ログアウトさせる
    reset_session
    flash[:notice] = 'ご利用いただきありがとうございました。またのご利用をお待ちしております'
    redirect_to root_path
    
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduce, :profile_image)
  end

end
