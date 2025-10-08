class RemoveInheritAmenitiesFromDevProjectsAndModelHouses < ActiveRecord::Migration[8.0]
  def change
    remove_column :dev_projects, :inherit_amenities, :boolean
    remove_column :model_houses, :inherit_amenities, :boolean
  end
end
