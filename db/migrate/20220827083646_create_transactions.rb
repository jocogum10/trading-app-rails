class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.string :stock_symbol
      t.integer :price
      t.integer :lot_size
      t.string :transaction_type
      t.integer :user_id

      t.timestamps
    end
  end
end
