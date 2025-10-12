class Realty < ApplicationRecord
  belongs_to :head_broker, class_name: "User"
  has_many :realty_memberships, dependent: :destroy
  has_many :users, through: :realty_memberships
  has_many :accreditations, dependent: :destroy

  has_one_attached :business_permit
  has_one_attached :banner
  has_one_attached :logo

  validates :name, presence: true
  validates :business_location, presence: true
  validates :email, presence: true
  validates :phone_number, presence: true

  validate :head_broker_must_be_broker, on: :create
  validate :one_realty_per_broker, on: :create
  validates :business_permit, total_file_size: { less_than: 400.kilobytes }
  validates :banner, total_file_size: { less_than: 800.kilobytes }
  validates :logo, total_file_size: { less_than: 500.kilobytes }

  enum :status, { pending: 0, approved: 1, rejected: 2 }

  def head_broker_must_be_broker
    if head_broker.present? && !head_broker.is_broker?
      errors.add(:head_broker, "must be a broker to create a realty.")
    end
  end

def one_realty_per_broker
  if head_broker.present? &&
     head_broker.managed_realty.present? &&
     head_broker.managed_realty != self
    errors.add(:head_broker, "can only manage one realty.")
  end
end

  scope :approved, -> { where(status: :approved) }

  def self.search(query)
    return all if query.blank?

    joins(:head_broker).where(
      "LOWER(realties.name) LIKE :q OR LOWER(users.first_name) LIKE :q OR LOWER(users.last_name) LIKE :q OR LOWER(users.email) LIKE :q",
      q: "%#{query.downcase}%"
    )
  end
end
