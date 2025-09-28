class ReviewEvent < ApplicationRecord
  belongs_to :realtor, class_name: "User", foreign_key: "realtor_id"
  belongs_to :client,  class_name: "User", foreign_key: "client_id", optional: true

  belongs_to :listing, optional: true
  belongs_to :review, optional: true

  validates :event_type, presence: true

  enum :event_type, { assigned: 'assigned', review: 'review' }
  scope :unread, -> { where(read: false) }
end

