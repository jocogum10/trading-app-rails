require "test_helper"

class TransactionsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "not logged in redirected to sign up page" do
    get transactions_path
    assert_redirected_to new_user_session_path
  end
end
