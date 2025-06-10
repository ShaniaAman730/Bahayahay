class AddColumnsToListing < ActiveRecord::Migration[8.0]
  def change
    add_column :listings, :owneralive, :boolean
    add_column :listings, :estatetax, :boolean
    add_column :listings, :ejsprocessed, :boolean
    add_column :listings, :citizenship, :integer
  end
end
