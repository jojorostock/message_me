require 'test_helper'

class FriendshipTest < ActiveSupport::TestCase
  test "Friendship creation" do
    @user1 = User.new(username: "user1", password: "password")
    @user1.save
    @user2 = User.new(username: "user2", password: "password")
    @user2.save
    @user1 = User.first
    @user2 = User.last
    @friends = Friendship.new(user_id: @user1.id, friend_id: @user2.id)

    assert @friends.valid?
  end
end
