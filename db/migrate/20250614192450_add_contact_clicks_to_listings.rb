class AddContactClicksToListings < ActiveRecord::Migration[8.0]
  def change
    add_column :listings, :contact_clicks, :integer
  end
end
