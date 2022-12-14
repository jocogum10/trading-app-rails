class Stock < ApplicationRecord
    validates :name, presence: true, uniqueness: true
    validates :symbol, presence: true, uniqueness: true
    validates :price, presence: true
end
