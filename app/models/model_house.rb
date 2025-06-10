class ModelHouse < ApplicationRecord

	has_and_belongs_to_many :dev_projects

	has_rich_text :description

	paginates_per 10

	enum :furnish_type, { "Fully furnished": 1, "Semi-furnished": 2, "Bare unit": 3 }
	has_many_attached :model_photos

end

