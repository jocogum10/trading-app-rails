require "test_helper"

class StockTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "stock model fields should not empty" do
    stock = Stock.new
    stock.name = ''
    stock.symbol = ''
    stock.price = ''
    assert_not stock.save, "Saved stock with empty fields"
  end

  test "stock model fields should not have duplicates" do
    first_stock = Stock.create(name: 'Advanced Micro Devices Inc.',symbol: 'AMD',price: 85.45 )
    second_stock = Stock.new
    second_stock.name = 'Advanced Micro Devices Inc.'
    second_stock.symbol = 'AMD'
    second_stock.price = 100.45
    assert_not second_stock.save, "Saved stock with existing value"
  end
end
