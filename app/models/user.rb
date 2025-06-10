class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  has_many :dev_project, dependent: :destroy
  has_many :listings_posted, class_name: "Listing", foreign_key: "realtor_id"
  has_many :listings_bought, class_name: "Listing", foreign_key: "client_id"
  has_many :client_conversations, class_name: "Conversation", foreign_key: "client_id"
  has_many :realtor_conversations, class_name: "Conversation", foreign_key: "realtor_id"
  has_many :sent_messages, class_name: "Message", foreign_key: "sender_id"
  has_many :received_reviews, class_name: "Review", foreign_key: "realtor_id"
  has_many :written_reviews, class_name: "Review", foreign_key: "client_id"


  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_photo
  has_one_attached :prc_id
  has_one_attached :dhsud_cert
  has_one_attached :gov_id

  enum :user_type, { admin: 0, developer: 1, realtor: 2, client: 3 }

  paginates_per 10

end
