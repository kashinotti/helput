class Users::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :like_post, :edit, :update, :follow_index, :follower_index, :withdraw]

  def index
    @users = User.all.where.not(is_deleted: true).order(updated_at: :desc).page(params[:page]).per(10)
    @q = @users.ransack(params[:q])
    @search_uesrs = @q.result(distinct: true).where.not(is_deleted: true)
  end

  def search_user_index
    # ransackのユーザーの検索結果を表示するための変数を定義
     @q = User.ransack(params[:q])
     @users = @q.result(distinct: true).where.not(is_deleted: true).order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
    # 更新順で１０個ごとにページングできるようにorder,perメソッドで設定
    @posts = @user.posts.order(updated_at: :desc).page(params[:page]).per(10)
    # 検索フォームの値を格納するために@qを定義
    @q = Post.ransack(params[:q])

    # チャットルームが作成されたときに各ユーザのUserRoomのテーブルが必要なので、whereメソッドで取得
    @currentUserRoom = UserRoom.where(user_id: current_user.id)
    @otherUserRoom = UserRoom.where(user_id: @user.id)

    unless @user.id == current_user.id
      # ログインユーザーと相手のUserRoomテーブルをeachで取り出し、＠roomIdに代入
      @currentUserRoom.each do |cu|
        @otherUserRoom.each do |ot|
          if cu.room_id == ot.room_id
            # まだチャットルームが作成されていなければ新しく作成しなければならない。
            # 作成されているか判断するためにtrueを代入
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end
    end
    
    # チャットルームが作成されていなければ新しくからのインスタンスを作成
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
    # 更新順で１０個ごとにページングできるようにorder,perメソッドで設定
    @likes = Like.where(user_id: @user.id).order(updated_at: :desc).page(params[:page]).per(10)
  end

  def edit
    # 他のユーザーがアクセスしようとしたときに遷移させないために条件分岐
    if @user.id != current_user.id
      if user_signed_in?
        redirect_to user_path(current_user.id)
      else
        redirect_to new_user_session_path
      end
    end
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  def follow_index
    # 退会済みのユーザー以外のユーザーを表示させるためにwhere.notで退会済みユーザーを除外
    @followings = @user.followings.all.where.not(is_deleted: true).order(created_at: :desc).page(params[:page]).per(10)
  end


  def follower_index
    # 退会済みのユーザー以外のユーザーを表示させるためにwhere.notで退会済みユーザーを除外
    @followers = @user.followers.all.where.not(is_deleted: true).order(created_at: :desc).page(params[:page]).per(10)
  end

  def unsubscribe
    @user = User.find_by(id: current_user.id)
  end

  def withdraw
    # is_deletedカラムをtrueにして論理削除
    @user.update(is_deleted: true)
    # 退会フラグ変更後にユーザーの投稿、いいね、コメントを全て削除し、他のユーザーに表示されないようにする
    @user.posts.destroy_all
    @user.likes.destroy_all
    @user.comments.destroy_all
    # ログアウトさせる
    reset_session
    redirect_to root_path

  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :introduce, :profile_image)
  end

end
