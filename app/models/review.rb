class Review < ApplicationRecord
  belongs_to :listing
  belongs_to :client, class_name: "User"
  belongs_to :realtor, class_name: "User"
  has_many :review_events, dependent: :destroy

  validates :knowledge_rating, :responsiveness_rating, :professionalism_rating, presence: true, inclusion: { in: 1..5 }
  validate :review_length_within_limit

  scope :unread, -> { where(read: false) }

  def review_length_within_limit
    max_chars = 500
    if comment.present? && comment.length > max_chars
      errors.add(:comment, "must be #{max_chars} characters or fewer")
    end
  end

end


