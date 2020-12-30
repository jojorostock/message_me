class Message < ApplicationRecord
    belongs_to :user
    validates :body, presence: true
    scope :custom_display, -> { order(:created_at).last(20) }
    has_one_attached :photo
end
