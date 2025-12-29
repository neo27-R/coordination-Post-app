class Events::ParticipationsController < ApplicationController
  before_action :require_login
  before_action :set_event

  def create
    current_user.event_participations.find_or_create_by!(event: @event)
    redirect_to @event, notice: "イベントに参加しました"
  end

  def destroy
    current_user.event_participations.find_by(event: @event)&.destroy
    redirect_to @event, notice: "参加を取り消しました"
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end
end
