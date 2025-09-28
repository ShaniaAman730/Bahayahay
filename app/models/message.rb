class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :sender, class_name: "User"
  
  validates :body, presence: true

  after_create_commit do
    broadcast_append_to(
      "conversation_#{conversation.id}_messages",
      target: "messages",
      partial: "messages/message",
      locals: { message: self }
    )
  end
end
