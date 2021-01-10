class Users::ChatsController < ApplicationController


    def create
      # form_withで送られてきたパラメータが入っているかを条件分岐で確認
      if UserRoom.where(user_id: params[:chat][:user_id], room_id: params[:chat][:room_id]).present?
        @chat = Chat.create(params.require(:chat).permit(:room_id, :user_id, :message).merge(user_id: current_user.id))
        respond_to do |format|
          format.html { redirect_to "room_path(params[:chat][:room_id])" }
          # render 'chat'でchat.json.jbuilderでマッピングした値を返すようにする
          format.json { render 'chat', handlers: 'jbuilder' }

        end
      else
        flash[:alert] = "メッセージ送信に失敗しました。"
      end
    end

end

