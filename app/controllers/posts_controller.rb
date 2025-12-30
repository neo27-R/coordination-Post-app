class PostsController < ApplicationController
    before_action :require_login
    before_action :set_event
    before_action :ensure_participant!

    def new
      @post = @event.posts.new
    end

    def create
      @post = @event.posts.new(post_params.merge(user_id: current_user.id))
      if @post.save
        redirect_to participant_posts_event_path(@event), notice: "投稿しました"
      else
        render :new, status: :unprocessable_entity
      end
    end

    private

    def set_event
      @event = Event.find(params[:event_id])
    end

    def post_params
      params.require(:post).permit(:body, :image)
    end

    # 参加者限定ガード（主催者もOK）
    def ensure_participant!
      return if @event.user_id == current_user.id
      return if current_user.event_participations.exists?(event_id: @event.id)

      redirect_to event_path(@event), alert: "参加者のみ投稿できます"
    end
end
