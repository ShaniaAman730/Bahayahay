class AddAdminMetadataToListings < ActiveRecord::Migration[8.0]
  def change
    add_column :listings, :valid_id_last4, :string
    add_column :listings, :tin_last4, :string
    add_column :listings, :birthcert_matches_id, :boolean
    add_column :listings, :tct_last4, :string
    add_column :listings, :tct_remarks, :text
  end
end
