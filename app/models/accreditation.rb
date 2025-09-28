class Accreditation < ApplicationRecord
  belongs_to :realty
  belongs_to :developer, class_name: "User"
  
  enum :status, { pending: 0, approved: 1, rejected: 2 }
end
