class AddForEditToListings < ActiveRecord::Migration[8.0]
  def change
    add_column :listings, :for_edit, :boolean, default: false
  end
end
