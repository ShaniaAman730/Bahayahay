class Review < ApplicationRecord
  belongs_to :listing
  belongs_to :client, class_name: "User"
  belongs_to :realtor, class_name: "User"
  has_many :review_events, dependent: :destroy

  validates :knowledge_rating, :responsiveness_rating, :professionalism_rating, presence: true, inclusion: { in: 1..5 }

  scope :unread, -> { where(read: false) }

end

