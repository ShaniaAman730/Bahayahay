class PropertyAmenity < ApplicationRecord
  belongs_to :amenity
  belongs_to :property, polymorphic: true
  validates :amenity_id, uniqueness: { scope: [:property_type, :property_id] }
end

