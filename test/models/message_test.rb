require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  test "Message creation should be valid" do
    @user = User.new(username: "user", password: "password")
    @user.save()
    @user = User.first
    @message = @user.messages.build(body: "test message")
    assert @message.valid?
  end

  test "Message creation should be valid if the user is not saved yet" do
    @user = User.new(username:"test")
    @message = @user.messages.build(body: "test message")
    assert @message.valid?
  end
end
