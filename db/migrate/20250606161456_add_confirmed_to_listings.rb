class AddConfirmedToListings < ActiveRecord::Migration[8.0]
  def change
    add_column :listings, :confirmed, :boolean
  end
end
