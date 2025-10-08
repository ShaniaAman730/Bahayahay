class MessagesController < ApplicationController
  before_action :set_conversation
  before_action :authorize_participant!

    def create
    @conversation = Conversation.find(params[:conversation_id])
    @message = @conversation.messages.build(message_params.merge(sender: current_user))
    recipient = @conversation.recipient_for(current_user)

    if @message.save
      ActionCable.server.broadcast(
        "notifications_#{recipient.id}",
        {
          type: "message",
          from: current_user.full_name,
          content: @message.body,
          conversation_id: @conversation.id,
          unread_increment: true
        }
      )

      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to conversation_path(@conversation) }
      end
    else
      respond_to do |format|
        format.html { render "conversations/show", status: :unprocessable_entity }
      end
    end
  end

  private

  def set_conversation
    @conversation = Conversation.find(params[:conversation_id])
  end

  def authorize_participant!
    unless @conversation.client_id == current_user.id || @conversation.realtor_id == current_user.id 
      redirect_to root_path, alert: "You're not part of this conversation."
    end
  end

  def message_params
    params.require(:message).permit(:body)
  end
end
