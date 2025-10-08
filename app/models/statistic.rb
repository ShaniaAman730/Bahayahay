class Statistic < ApplicationRecord
  belongs_to :trackable, polymorphic: true
  belongs_to :user, optional: true

  enum :event_type, { view: 0, contact_click: 1 }
  
  scope :for_period, ->(range) { where(created_at: range) }
end
