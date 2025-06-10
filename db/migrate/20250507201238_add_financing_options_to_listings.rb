class AddFinancingOptionsToListings < ActiveRecord::Migration[8.0]
  def change
    add_column :listings, :bank_financing, :boolean, default: false, null: false
    add_column :listings, :inhouse_financing, :boolean, default: false, null: false
    add_column :listings, :pagibig_financing, :boolean, default: false, null: false
  end
end

