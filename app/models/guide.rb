class Guide < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy

  has_one_attached :guide_photo

  has_rich_text :body
  validate :body_length_within_limit

  validates :title, :body, presence: true

  def self.search(keyword)
    where("title ILIKE ? OR body ILIKE ?", "%#{keyword}%", "%#{keyword}%")
  end

  def body_length_within_limit
    max_chars = 10000
    if body.to_plain_text.length > max_chars
      errors.add(:body, "must be #{max_chars} characters or fewer")
    end
  end
end
