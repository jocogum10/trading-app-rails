require "test_helper"

class TransactionsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "not logged in users can access the static home page" do
    get pages_home_path
    assert_response :success
  end

  test "not logged in users can access the static about page" do
    get pages_about_path
    assert_response :success
  end

  test "not logged in users redirected to sign in when accessing not the static pages" do
    get transactions_path
    assert_redirected_to new_user_session_path
  end

  # test "As a Trader, I want to create an account to buy and sell stocks" do
  #   post user_session_path
  #   sign_in users(:admin)
  #   post user_session_url
  #   assert_redirected_to root_path
  # end
end
