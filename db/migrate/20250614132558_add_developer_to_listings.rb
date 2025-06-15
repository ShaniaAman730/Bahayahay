class AddDeveloperToListings < ActiveRecord::Migration[8.0]
  def change
    add_column :listings, :developer_id, :integer
  end
end
