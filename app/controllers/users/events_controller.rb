class Users::EventsController < ApplicationController
  before_action :authenticate_user!

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.user_id = current_user.id
    if @event.save
      redirect_to user_events_path(@event.user_id)
    else
      render 'new'
    end
  end

  def index
    @user = User.find(params[:user_id])

    #jsonでeventテーブルのレコードを読み込むとindex.json.jbuilderで定義したstartとendがstart_date,end_dateになっていてカレンダーに表示できない現象あり。
    #対応として、ASでstart,endに変換する。
    @events = Event.where(user_id: @user.id).select('id, user_id, title, content, start_date AS start, end_date AS end')
  end

  def show
    @event = Event.find(params[:id])
  end

  def edit
    @event = Event.find(params[:id])
    # 他のユーザーがアクセスしようとしたときに遷移させないために条件分岐
    if @event.user_id != current_user.id
      if user_signed_in?
        redirect_to user_path(current_user.id)
      else
        new_user_session_path
      end
    end
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      redirect_to user_events_path(user_id: current_user.id)
    else
      render 'edit'
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to user_events_path(user_id: current_user.id)
  end

  private

  def event_params
    params.require(:event).permit(:user_id, :title, :content, :start_date, :end_date)
  end


end
