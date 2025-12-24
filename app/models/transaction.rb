class Transaction < ApplicationRecord
  belongs_to :listing
  belongs_to :buyer, class_name: "User"
  belongs_to :seller, class_name: "User"

  scope :completed, -> { where(reversed_at: nil) }
  scope :reversed,  -> { where.not(reversed_at: nil) }

  scope :this_month, -> {
    completed.where(sold_at: Time.current.beginning_of_month..Time.current.end_of_month)
  }

  scope :this_year, -> {
    completed.where(sold_at: Time.current.beginning_of_year..Time.current.end_of_year)
  }
end
