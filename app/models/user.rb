class User < ApplicationRecord
    validates :username, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 3, maximum: 15 }
    has_many :messages
    has_many :friendships
    has_many :friends, through: :friendships
    has_secure_password
end
