class Amenity < ApplicationRecord
  has_many :property_amenities, dependent: :destroy
  has_many :listings, through: :property_amenities, source: :property, source_type: 'Listing'
  has_many :model_houses, through: :property_amenities, source: :property, source_type: 'ModelHouse'
  has_many :dev_projects, through: :property_amenities, source: :property, source_type: 'DevProject'

  enum :category, { unit: 0, project: 1 }

  validates :name, presence: true
  validates :label, presence: true
  validates :category, presence: true
  validates :name, uniqueness: { scope: :category } # same name allowed if different category
end
