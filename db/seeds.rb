# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
client = IEX::Api::Client.new(
    publishable_token: ENV['IEX_TOKEN'],
    secret_token: ENV['IEX_SECRET_TOKEN'],
    endpoint: 'https://cloud.iexapis.com/v1'
)
top_stocks = client.stock_market_list(:mostactive)

top_stocks.each do |stock|
    Stock.create(name: stock["company_name"], symbol: stock["symbol"], price: stock["latest_price"])
end