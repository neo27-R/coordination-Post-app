class User < ApplicationRecord
  has_many :events, dependent: :destroy
  has_many :event_participations, dependent: :destroy
  has_many :participating_events, through: :event_participations, source: :event

  authenticates_with_sorcery!

  validates :password, length: { minimum: 8 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :name, presence: true, length: { maximum: 20 }
  validates :email, presence: true, uniqueness: true
end
