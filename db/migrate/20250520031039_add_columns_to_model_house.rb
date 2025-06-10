class AddColumnsToModelHouse < ActiveRecord::Migration[8.0]
  def change
    add_column :model_houses, :beds, :integer
    add_column :model_houses, :baths, :integer
    add_column :model_houses, :sqft, :integer
    add_column :model_houses, :bank_financing, :boolean, default: false, null: false
    add_column :model_houses, :inhouse_financing, :boolean, default: false, null: false
    add_column :model_houses, :pagibig_financing, :boolean, default: false, null: false
  end
end
