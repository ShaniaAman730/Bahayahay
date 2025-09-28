class RealtyMembership < ApplicationRecord
  belongs_to :realty
  belongs_to :user

  enum :status, { pending: 0, approved: 1, rejected: 2, leaving: 3, left: 4 }
end
