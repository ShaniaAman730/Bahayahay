class ChangeDefaultForInheritAmenitiesInDevProjects < ActiveRecord::Migration[8.0]
  def change
    change_column_default :dev_projects, :inherit_amenities, from: nil, to: false
    change_column_null :dev_projects, :inherit_amenities, false
  end
end
