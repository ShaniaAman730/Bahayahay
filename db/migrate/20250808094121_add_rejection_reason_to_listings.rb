class AddRejectionReasonToListings < ActiveRecord::Migration[8.0]
  def change
    add_column :listings, :rejection_reason, :string
  end
end
