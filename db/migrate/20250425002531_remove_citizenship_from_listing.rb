class RemoveCitizenshipFromListing < ActiveRecord::Migration[8.0]
  def change
    remove_column :listings, :citizenship, :string
  end
end
