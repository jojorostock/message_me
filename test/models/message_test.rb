require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  def setup 
    @user = User.new(username: "user", password: "password")
  end

  test "Message creation should be valid" do
    @user.save()
    @user = User.first
    @message = @user.messages.build(body: "test message")
    assert @message.valid?
  end

  test "Message creation should be valid if the user is not saved yet" do
    @message = @user.messages.build(body: "test message")
    assert @message.valid?
  end
end
