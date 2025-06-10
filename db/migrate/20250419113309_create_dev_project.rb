class CreateDevProject < ActiveRecord::Migration[8.0]
  def change
    create_table :dev_projects do |t|
      t.string :title
      t.text :description
      t.string :barangay
      t.string :address
      t.boolean :inherit_amenities

      t.timestamps
    end
  end
end
