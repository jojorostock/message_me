class User < ApplicationRecord
    validates :username, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 3, maximum: 15 }
    validates :password, length: {minimum: 6}
    has_many :messages
    has_many :friendships
    has_many :friends, through: :friendships
    has_many :likes, dependent: :destroy
    has_secure_password
    has_one_attached :avatar
end
