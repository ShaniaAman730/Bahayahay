class ConversationsController < ApplicationController
  before_action :authenticate_user! # assumes Devise or similar
  before_action :set_conversation, only: [:show]

  def index
    @conversations = if current_user.realtor?
      current_user.realtor_conversations.includes(:client)
    else
      current_user.client_conversations.includes(:realtor)
    end
  end

  def show
    @messages = @conversation.messages.order(created_at: :asc)
    @message = Message.new
  end

  def create
    @realtor = User.find(params[:realtor_id])

    # Check if a conversation already exists
    @conversation = Conversation.find_by(client_id: current_user.id, realtor_id: @realtor.id)


    unless @conversation
      @conversation = Conversation.create(client_id: current_user.id, realtor_id: @realtor.id)
    end

    redirect_to conversation_path(@conversation)
  end

  private

  def set_conversation
    @conversation = Conversation.find(params[:id])
  end
end
