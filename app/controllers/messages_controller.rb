class MessagesController < ApplicationController
  before_action :set_conversation
  before_action :authorize_participant!

  def create
    @conversation = Conversation.find(params[:conversation_id])
    @message = @conversation.messages.build(message_params)
    @message.sender = current_user

    if @message.save
      respond_to do |format|

        format.turbo_stream
        format.html { redirect_to conversation_path(@conversation) }
      end
    else
      # fallback in case of error
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
