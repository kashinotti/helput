class Users::RoomsController < ApplicationController
  
  def create
    @room = Room.create
    @userRoom1 = UserRoom.create(room_id: @room.id, user_id: current_user.id)
    @userRoom2 = UserRoom.create(params.require(:user_room).permit(:user_id, :room_id).merge(room_id: @room.id))
    redirect_to room_path(@room.id)
  end
  
  def show
    @room = Room.find(params[:id])
    # @userRoom = UserRoom.find(params[:id])
    if UserRoom.where(user_id: current_user.id, room_id: @room.id).present?
      # ルーム内のチャットメッセージを表示させるために定義
      @chats = @room.chats
      # 新規メッセージを送信するために定義
      @chat = Chat.new
      # ルームにユーザーの名前やプロフィール画像を表示させるために定義
      @userRooms = @room.user_rooms
    else
      redirect_to user_path(current_user.id)
    end
  end
  
end
