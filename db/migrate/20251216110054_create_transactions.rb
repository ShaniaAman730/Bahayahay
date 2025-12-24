class CreateTransactions < ActiveRecord::Migration[8.0]
  def change
    create_table :transactions do |t|
      t.references :listing, null: false, foreign_key: true
      t.references :buyer, null: false, foreign_key: { to_table: :users }
      t.references :seller, null: false, foreign_key: { to_table: :users }

      t.decimal :price, precision: 15, scale: 2
      t.datetime :sold_at, null: false
      t.timestamps
    end
  end
end
