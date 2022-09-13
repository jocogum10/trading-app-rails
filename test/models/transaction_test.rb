require "test_helper"

class TransactionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "transaction type should not be any value other than buy or sell" do
    transaction = Transaction.new
    transaction.stock_symbol = 'AMD'
    transaction.price = 100
    transaction.lot_size = 100
    transaction.transaction_type = 'hold'
    transaction.user_id = 1
    assert_not transaction.save, "Transaction saved with different transaction type"
  end

  test "transaction type should not have a lot size of 0" do
    transaction = Transaction.new
    transaction.stock_symbol = 'AMD'
    transaction.price = 100
    transaction.lot_size = 0
    transaction.transaction_type = 'sell'
    transaction.user_id = 1
    assert_not transaction.save, "Transaction saved with different transaction type"
  end
end
