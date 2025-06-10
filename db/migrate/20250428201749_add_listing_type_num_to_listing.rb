class AddListingTypeNumToListing < ActiveRecord::Migration[8.0]
  def change
    add_column :listings, :listing_type_num, :integer
  end
end
