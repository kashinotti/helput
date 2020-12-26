class Users::EventsController < ApplicationController


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
    #そのため、ASでstart,endに変換し、jsonで取得する。
    @events = Event.where(user_id: @user.id).select('id, user_id, title, content, start_date AS start, end_date AS end').as_json
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @events }
    end
  end

  def show
    @events = Event.find(params[:id])
  end

  def edit
    unless @event.user == current_user
      redirect_to root_path
    end
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      redirect_to events_path
    else
      render 'edit'
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to events_path
  end

  private

  def event_params
    params.require(:event).permit(:user_id, :title, :content, :start_date, :end_date)
  end


end
