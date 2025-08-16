class AddCustomReasonToListings < ActiveRecord::Migration[8.0]
  def change
    add_column :listings, :custom_reason, :string
  end
end
