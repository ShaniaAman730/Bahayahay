class Review < ApplicationRecord
  belongs_to :listing, dependent: :destroy
  belongs_to :client, class_name: "User"
  belongs_to :realtor, class_name: "User"

  validates :knowledge_rating, :responsiveness_rating, :professionalism_rating, presence: true, inclusion: { in: 1..5 }

end
