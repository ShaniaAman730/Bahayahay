class RemoveBarangayFromDevProject < ActiveRecord::Migration[8.0]
  def change
    remove_column :dev_projects, :barangay, :string
  end
end
