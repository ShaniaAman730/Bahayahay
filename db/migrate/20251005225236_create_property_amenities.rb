class CreatePropertyAmenities < ActiveRecord::Migration[8.0]
  def change
    create_table :property_amenities do |t|
      t.references :amenity, null: false, foreign_key: true
      t.references :property, polymorphic: true, null: false  # property_type, property_id

      t.timestamps
    end

    add_index :property_amenities, [:property_type, :property_id]
    add_index :property_amenities, [:property_type, :property_id, :amenity_id], unique: true, name: 'index_property_amenities_on_property_and_amenity'
  end
end