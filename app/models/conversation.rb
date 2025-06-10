class Conversation < ApplicationRecord
  belongs_to :client, class_name: "User"
  belongs_to :realtor, class_name: "User"
  has_many :messages, dependent: :destroy

  validates :client_id, presence: true
  validates :realtor_id, presence: true
end
