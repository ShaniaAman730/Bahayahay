class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  has_many :dev_projects, foreign_key: :user_id, dependent: :destroy
  has_many :model_houses, through: :dev_projects

  has_many :listings_posted, class_name: "Listing", foreign_key: "realtor_id", dependent: :destroy
  has_many :listings_bought, class_name: "Listing", foreign_key: "client_id", dependent: :nullify
  has_many :listings_as_developer, class_name: "Listing", foreign_key: "developer_id", dependent: :nullify

  has_many :client_conversations, class_name: "Conversation", foreign_key: "client_id", dependent: :destroy
  has_many :realtor_conversations, class_name: "Conversation", foreign_key: "realtor_id", dependent: :destroy

  has_many :sent_messages, class_name: "Message", foreign_key: "sender_id", dependent: :destroy

  has_many :received_reviews, class_name: "Review", foreign_key: "realtor_id", dependent: :destroy
  has_many :written_reviews, class_name: "Review", foreign_key: "client_id", dependent: :destroy
  has_many :realtor_review_events, class_name: "ReviewEvent", foreign_key: "realtor_id", dependent: :destroy
  has_many :client_review_events,  class_name: "ReviewEvent", foreign_key: "client_id", dependent: :destroy


  has_many :guides, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :saved_listings, dependent: :destroy
  has_many :saved_listings_listings, through: :saved_listings, source: :listing

  # A broker can manage one realty (keep realty even if broker is deleted)
  has_one :managed_realty, class_name: "Realty", foreign_key: :head_broker_id

  # A realtor (non-broker) can belong to one realty
  has_one :realty_membership, foreign_key: :user_id, dependent: :destroy
  has_one :realty, through: :realty_membership

  # Developer role
  has_many :developer_accreditations, class_name: "Accreditation", foreign_key: "developer_id", dependent: :destroy
  has_many :accredited_realties, through: :developer_accreditations, source: :realty

  # Statistics
  has_many :statistics, as: :trackable, dependent: :destroy

  # REBAP
  has_many :rebap_memberships, foreign_key: :rebap_id, dependent: :destroy
  has_many :active_members, through: :rebap_memberships, source: :member
  has_many :member_rebap_memberships, class_name: "RebapMembership", foreign_key: :member_id, dependent: :destroy


  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum :user_type, { admin: 0, developer: 1, realtor: 2, client: 3, rebap: 4 }

  # helper to check if this user is a head broker
  def head_broker?
    managed_realty.present?
  end
  
  has_one_attached :profile_photo
  has_one_attached :prc_id
  has_one_attached :dhsud_cert
  has_one_attached :gov_id
  
  validates :first_name, presence: true, on: :create, unless: -> { user_type.in?(%w[developer rebap]) }
  validates :last_name, presence: true, on: :create, unless: -> { user_type.in?(%w[developer rebap]) }
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }, on: :create
  validates :contact_no, presence: true, on: :create
  validates :privacy_agreement, acceptance: true, if: -> { realtor? }, on: :create
  validate :broker_must_exist_if_not_broker, if: -> { realtor? && !is_broker }, on: :create
  
  validates :profile_photo, total_file_size: { less_than: 500.kilobytes }
  validates :prc_id, total_file_size: { less_than: 400.kilobytes }
  validates :dhsud_cert, total_file_size: { less_than: 400.kilobytes }
  validates :gov_id, total_file_size: { less_than: 400.kilobytes }

  # Validation for broker details if not a broker
  with_options if: -> { user_type == 2 && is_broker == false } do
      validates :broker_name, presence: true, on: :create
      validates :broker_prc_no, presence: true, on: :create
  end
  
  validate :about_length_within_limit

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

  def unread_messages_count
    Message.joins(:conversation)
           .where(read: false)
           .where("(conversations.client_id = :id OR conversations.realtor_id = :id) AND messages.sender_id != :id", id: self.id)
           .count
  end

  def broker_must_exist_if_not_broker
    # Find broker by name 
    broker = User.find_by("LOWER(CONCAT(first_name, ' ', last_name)) = ?", broker_name.to_s.downcase)

    # or by prc_no 
    if broker.nil? && broker_prc_no.present?
      broker = User.find_by(prc_no: broker_prc_no)
    end

    if broker.nil?
      errors.add(:broker_name, "must match an existing broker in the system")
      return
    end

    unless broker.head_broker? # broker must already manage a Realty
      errors.add(:base, "Your broker must have an existing Realty created before you can sign up.")
    end
  end

  def total_views
    statistics.view.count
  end

  def unique_visitors
    statistics.view.distinct.count(:visitor_id)
  end

  def any_email_sent?
    welcome_email_sent_at.present? || realtor_approval_email_sent_at.present? || realtor_rejection_email_sent_at.present?
  end

  def about_length_within_limit
    max_chars = 500
    if about.present? && about.length > max_chars
      errors.add(:about, "must be #{max_chars} characters or fewer")
    end
  end



end
