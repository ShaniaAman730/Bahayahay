class ModelHouse < ApplicationRecord

	has_and_belongs_to_many :dev_projects

	has_rich_text :description

	paginates_per 10

	enum :furnish_type, { "Fully furnished": 1, "Semi-furnished": 2, "Bare unit": 3 }

	has_many_attached :model_photos
	validate :model_photos_limit

	def model_photos_limit
	  if model_photos.attached? && model_photos.count > 8
	    errors.add(:model_photos, "You can only upload up to 8 files.")
	  end
	end

end

