class AddDetailsToListings < ActiveRecord::Migration[8.0]
  def change
    add_column :listings, :beds, :integer
    add_column :listings, :baths, :integer
    add_column :listings, :sqft, :integer
  end
end
