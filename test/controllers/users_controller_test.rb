require "test_helper"


class UsersControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers

  def setup
    @user = users(:one)
    @user2 = users(:two)

    sign_in @user
    @controller.params = { id: @user2.id }
  end

  test "user#follow and user#unfollow should add and remove the current user as a follower to another user" do
    assert_not @user2.followers.first

    @controller.follow

    assert_equal @user2.followers.first, @user

    @controller.unfollow

    assert_not @user2.followers.first
  end

  test "user#follow and user#unfollow should add and remove the other user as a followee to the current user" do
    assert_not @user.followees.first

    @controller.follow

    assert_equal @user.followees.first, @user2

    @controller.unfollow

    assert_not @user.followees.first
  end
end
