class RemoveListingTypeFromListings < ActiveRecord::Migration[8.0]
  def change
    remove_column :listings, :listing_type, :integer
  end
end
