require "test_helper"

class AdminControllerTest < ActionDispatch::IntegrationTest

  test "should no admin route exist when not logged in" do
    get dashboard_path
    assert_response 'Not Found'
  end

  test "should get index" do
    get dashboard_path
    assert_redirected_to new_user_session_path
  end

  test "should get users" do
    get show_user_path(id: 1)
    assert_redirected_to new_user_session_path
  end

  test "should get show_user" do
    get new_user_path
    assert_redirected_to new_user_session_path
  end
end
