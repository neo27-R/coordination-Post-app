class Event < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :start_at, presence: true
  validates :body, presence: true

  has_many :event_participations, dependent: :destroy
  has_many :participants, through: :event_participations, source: :user

  after_create :join_host!

  private

  def join_host!
    event_participations.find_or_create_by!(user_id: user_id)
  end
end
