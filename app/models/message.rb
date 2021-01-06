class Message < ApplicationRecord
    belongs_to :user
    has_many :likes, dependent: :destroy
    validates :body, presence: true
    scope :custom_display, -> { where(friend_id: 0).order(:created_at).last(20) }
    has_one_attached :photo
end
