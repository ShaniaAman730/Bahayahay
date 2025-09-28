class CreateReviewEvents < ActiveRecord::Migration[8.0]
  def change
    create_table :review_events do |t|
      t.references :client, foreign_key: { to_table: :users }, null: false
      t.references :realtor, foreign_key: { to_table: :users }, null: false
      t.references :listing, null: false, foreign_key: true
      t.string :event_type
      t.text :message

      t.timestamps
    end
  end
end
