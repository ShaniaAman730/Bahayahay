class AddBarangayToDevProject < ActiveRecord::Migration[8.0]
  def change
    add_column :dev_projects, :barangay, :integer
  end
end
