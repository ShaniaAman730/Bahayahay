class AddRealtorAndClientToListings < ActiveRecord::Migration[8.0]
  def change
    add_reference :listings, :realtor, foreign_key: { to_table: :users }, null: false
    add_reference :listings, :client, foreign_key: { to_table: :users }, null: true
  end
end
