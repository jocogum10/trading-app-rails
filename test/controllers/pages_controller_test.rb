require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home without logging in" do
    get pages_home_url
    assert_response :success
  end

  test "should get about without logging in" do
    get pages_about_url
    assert_response :success
  end
end
