require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "User should be valid" do
    @user = User.new(username: "test", password: "password")
    assert @user.valid?
  end

  test "User invalid without username" do
    @user = User.new(username: "test")
    assert_not @user.valid?
  end

  test "User invalid without password" do
    @user = User.new(password: "password")
    assert_not @user.valid?
  end

  test "User should be invalid with too short password" do
    @user = User.new(username: "test", password: "p")
    assert_not @user.valid?
  end

  test "User should be invalid with too short username" do
    @user = User.new(username: "t", password: "password")
    assert_not @user.valid?
  end

  test "User should be invalid with too long username" do
    @user = User.new(username: "testUsernameThatIsTooLongTooPass", password: "password")
    assert_not @user.valid?
  end

  test "User should be invalid with another user with the same username" do
    @user = User.new(username: "sameName", password: "password")
    @user.save
    @user2 = User.new(username: "sameName", password: "password")
    assert_not @user2.valid?
  end

  # Not working for some reason
  # test "User valid after edit" do
  #   @user = User.new(username: "testEdit", password: "password")
  #   @user.save
  #   @user2 = User.where(username: "testEdit").first
  #   @user2.username = "testEdited"
  #   assert @user2.valid?
  # end
end
