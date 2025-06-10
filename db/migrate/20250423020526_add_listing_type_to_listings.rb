class AddListingTypeToListings < ActiveRecord::Migration[8.0]
  def change
    add_column :listings, :listing_type, :string
  end
end
