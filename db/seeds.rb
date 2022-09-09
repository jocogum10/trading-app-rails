# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Stock.create(name: "Apple Inc", symbol: "AAPL", price: 154 )
Stock.create(name: "Alphabet Inc Class A", symbol: "GOOGL", price: 108 )
Stock.create(name: "Tesla Inc", symbol: "TSLA", price: 289 )