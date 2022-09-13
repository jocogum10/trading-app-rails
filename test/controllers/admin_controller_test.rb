require "test_helper"

class AdminControllerTest < ActionDispatch::IntegrationTest

  test "not logged in redirected to sign up page" do
    get dashboard_path
    assert_redirected_to new_user_session_path
  end
end
