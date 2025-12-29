class EventsController < ApplicationController
  before_action :require_login
  before_action :set_event, only: %i[show edit update destroy]
  before_action :authorize_event!, only: %i[edit update destroy]

  def index
    @events = Event.order(created_at: :desc)
  end

  def show
  end

  def new
    @event = current_user.events.build
  end

  def create
    @event = current_user.events.build(event_params)

    if @event.save
      redirect_to @event, notice: "イベントを作成しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @event.update(event_params)
      redirect_to @event, notice: "イベントを更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @event.destroy
    redirect_to events_path, notice: "イベントを削除しました"
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def authorize_event!
    return if @event.user_id == current_user.id
    redirect_to @event, alert: "権限がありません"
  end

  def event_params
    params.require(:event).permit(:title, :body, :start_at)
  end
end
