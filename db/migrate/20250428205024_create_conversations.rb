class CreateConversations < ActiveRecord::Migration[8.0]
  def change
    create_table :conversations do |t|
      t.references :client, foreign_key: { to_table: :users }, null: false
      t.references :realtor, foreign_key: { to_table: :users }, null: false

      t.timestamps
    end
  end
end
