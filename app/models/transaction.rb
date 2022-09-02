class Transaction < ApplicationRecord
    belongs_to :user

    validates :transaction_type, inclusion: {in: ['buy', 'sell']}

    TRANSACTION_TYPE = [
        ['Buy', 'buy'],
        ['Sell', 'sell']
    ]
end
