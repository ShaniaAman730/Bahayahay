class Conversation < ApplicationRecord
  belongs_to :client, class_name: "User"
  belongs_to :realtor, class_name: "User"
  has_many :messages, dependent: :destroy

  validates :client_id, presence: true
  validates :realtor_id, presence: true

  def recipient_for(user)
    user.id == realtor_id ? client : realtor
  end

end
