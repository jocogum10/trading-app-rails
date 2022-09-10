# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
client = IEX::Api::Client.new(
    publishable_token: 'pk_357b98eff382413285d895c98242c6a8',
    secret_token: 'sk_4fa4a6ff12c64c97839dca46df3b5406',
    endpoint: 'https://cloud.iexapis.com/v1'
)
top_stocks = client.stock_market_list(:mostactive)

top_stocks.each do |stock|
    Stock.create(name: stock["company_name"], symbol: stock["symbol"], price: stock["latest_price"])
end