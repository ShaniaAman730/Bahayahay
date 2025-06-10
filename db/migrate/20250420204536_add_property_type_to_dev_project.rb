class AddPropertyTypeToDevProject < ActiveRecord::Migration[8.0]
  def change
    add_column :dev_projects, :property_type, :integer
  end
end
