class Transaction < ApplicationRecord
    belongs_to :user

    validates :transaction_type, inclusion: {in: ['buy', 'sell']}
    validates :price, presence: true, numericality: { greater_than: 0 }
    validates :lot_size, presence: true, numericality: { greater_than: 0 }

    TRANSACTION_TYPE = [
        ['Buy', 'buy'],
        ['Sell', 'sell']
    ]
end
