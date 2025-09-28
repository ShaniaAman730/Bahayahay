class AddLatitudeAndLongitudeToDevProjects < ActiveRecord::Migration[8.0]
  def change
    add_column :dev_projects, :latitude, :decimal, precision: 10, scale: 6
    add_column :dev_projects, :longitude, :decimal, precision: 10, scale: 6
  end
end
