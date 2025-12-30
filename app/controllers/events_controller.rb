class EventsController < ApplicationController
  before_action :require_login, except: %i[index show]
  before_action :set_event, only: %i[show edit update destroy joined participant_posts]
  before_action :authorize_event!, only: %i[edit update destroy]
  before_action :ensure_participant!, only: %i[joined participant_posts]

  def index
    @events = Event.order(created_at: :desc)
  end

  def show
    @participated = logged_in? && current_user.event_participations.exists?(event_id: @event.id)
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

  # 参加後ページ
  def joined
  end

  # 参加者だけが見れる「参加者のコーデ一覧」
  def participant_posts
    @posts = @event.posts.includes(:user).order(created_at: :desc)
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def authorize_event!
    return if @event.user_id == current_user.id
    redirect_to @event, alert: "権限がありません"
  end

  # 参加者限定ガード（主催者は常にOKにする設計）
  def ensure_participant!
    return if @event.user_id == current_user.id
    return if current_user.event_participations.exists?(event_id: @event.id)

    redirect_to event_path(@event), alert: "参加者のみ閲覧できます"
  end

  def event_params
    params.require(:event).permit(:title, :body, :start_at)
  end
end
