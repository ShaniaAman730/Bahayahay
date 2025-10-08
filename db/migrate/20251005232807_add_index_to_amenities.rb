class AddIndexToAmenities < ActiveRecord::Migration[8.0]
  def change
    add_index :amenities, [:name, :category], unique: true
  end
end
