class Guide < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy

  has_one_attached :guide_photo

  has_rich_text :body

  validates :title, :body, presence: true

  def self.search(keyword)
    where("title ILIKE ? OR body ILIKE ?", "%#{keyword}%", "%#{keyword}%")
  end
end
