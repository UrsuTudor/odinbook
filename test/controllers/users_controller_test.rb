require "test_helper"


class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should return posts#index when user is signed_in" do
    sign_in User.first
    get root_path
    assert_response :success
  end

  test "should redirect to sign_in when user is not logged in" do
    get root_path
    assert_redirected_to user_session_path
  end
end
