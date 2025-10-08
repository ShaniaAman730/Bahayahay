class CreateStatistics < ActiveRecord::Migration[8.0]
  def change
    create_table :statistics do |t|
      t.references :trackable, polymorphic: true, null: false
      t.references :user, foreign_key: true, null: true
      t.integer :event_type, null: false, default: 0
      t.timestamps
    end
  end
end
