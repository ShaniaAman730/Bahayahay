class RemoveUniqueIndexFromAmenitiesName < ActiveRecord::Migration[8.0]
  def change
    remove_index :amenities, name: "index_amenities_on_name"
  end
end
