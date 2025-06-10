class CreateReviews < ActiveRecord::Migration[8.0]
  def change
    create_table :reviews do |t|
      t.integer :rating
      t.text :comment
      t.references :listing, null: false, foreign_key: true
      t.references :client, foreign_key: { to_table: :users }, null: false
      t.references :realtor, foreign_key: { to_table: :users }, null: false

      t.timestamps
    end
  end
end

