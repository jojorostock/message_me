require 'test_helper'

class LikesControllerTest < ActionDispatch::IntegrationTest
  test "Likes Creation" do
    u = User.create(username: "test", password: "testPassword")
    u.messages.create(body: "test message")
    like = Like.new(message_id: u.messages.first.id, user_id: u.id)
    assert like.valid?()
  end

  test "Likes Deletion" do
    u = User.create(username: "test", password: "testPassword")
    u.messages.create(body: "test message")
    like = Like.new(message_id: u.messages.first.id, user_id: u.id)
    like.save
    assert u.likes.count == 1
    u.likes.first.destroy
    assert u.likes.count == 0
  end

  test "Adding many likes" do
    u = User.create(username: "test", password: "testPassword")
    for i in 1..10
      u.messages.create(body: i.to_s)
      like = Like.new(message_id: u.messages.last.id, user_id: u.id)
      like.save
    end
    # puts(u.likes.count)
    assert u.likes.count == 10
  end

  test "Likes dependent on message existance" do
    u = User.create(username: "test", password: "testPassword")
    u.messages.create(body: "test message")
    like = Like.new(message_id: u.messages.first.id, user_id: u.id)
    like.save
    assert u.likes.count == 1
    u.messages.first.destroy
    assert u.likes.count == 0
  end

  test "Likes dependent on user existance" do
    u = User.create(username: "test", password: "testPassword")
    u.messages.create(body: "test message")
    like = Like.new(message_id: u.messages.first.id, user_id: u.id)
    like.save
    x = Like.count
    User.first.destroy
    assert Like.count == x-1
  end
  
end
