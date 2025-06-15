class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  has_many :dev_projects, foreign_key: :user_id, dependent: :destroy
  has_many :model_houses, through: :dev_projects
  has_many :listings_posted, class_name: "Listing", foreign_key: "realtor_id"
  has_many :listings_bought, class_name: "Listing", foreign_key: "client_id"
  has_many :client_conversations, class_name: "Conversation", foreign_key: "client_id"
  has_many :realtor_conversations, class_name: "Conversation", foreign_key: "realtor_id"
  has_many :sent_messages, class_name: "Message", foreign_key: "sender_id"
  has_many :received_reviews, class_name: "Review", foreign_key: "realtor_id"
  has_many :written_reviews, class_name: "Review", foreign_key: "client_id"
  has_many :listings_as_developer, class_name: "Listing", foreign_key: "developer_id"
  has_many :guides, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :saved_listings
  has_many :saved_listings_listings, through: :saved_listings, source: :listing

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_photo
  has_one_attached :prc_id
  has_one_attached :dhsud_cert
  has_one_attached :gov_id

  enum :user_type, { admin: 0, developer: 1, realtor: 2, client: 3 }

  paginates_per 10

  def full_name
    "#{first_name} #{last_name}"
  end

  scope :approved_realtors, -> {
    where(user_type: "realtor", admin_approved: true)
  }

  def self.search_realtors(keyword)
    if keyword.present?
      approved_realtors.where(
        "first_name ILIKE :q OR last_name ILIKE :q OR company_name ILIKE :q OR about ILIKE :q",
        q: "%#{keyword}%"
      )
    else
      approved_realtors
    end
end


end
