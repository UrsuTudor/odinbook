require "test_helper"

class FollowRequestsControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers

  def setup
    @user = users(:one)
    @user2 = users(:two)

    sign_in @user
    @controller.params = { id: @user2.id }
  end

  test "Should send a follow request to user2" do
  end
end
