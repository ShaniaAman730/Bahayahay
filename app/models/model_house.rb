class ModelHouse < ApplicationRecord

	belongs_to :dev_project, optional: true

	has_rich_text :description
	has_many_attached :model_photos
	
	validate :model_photos_limit
	validates :model_photos, total_file_size: { less_than: 2.megabytes }

	validates :title, presence: true
  	validates :beds, :baths, :sqft, numericality: { only_integer: true, allow_nil: true }
  	validates :price, numericality: { allow_nil: true }

	paginates_per 10

	enum :furnish_type, { "Fully furnished": 1, "Semi-furnished": 2, "Bare unit": 3 }

	def model_photos_limit
	  if model_photos.attached? && model_photos.count > 14
	    errors.add(:model_photos, "You can only upload up to 8 files.")
	  end
	end

end

