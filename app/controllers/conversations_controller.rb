class ConversationsController < ApplicationController
  def index
    @conversations = current_user.mailbox.conversations
  end

  def show
    @conversation = current_user.mailbox.conversations.find(params[:id])
    @conversation.recipients.each do |recipient|
      recipient.id == current_user.id ? @user = recipient : @interlocutor = recipient
    end
  end


  def new
    @recipient = params[:user_id]
  end

  def create 
    recipient = User.find(params[:user_id])
    receipt = current_user.send_message(recipient, params[:body], params[:subject])
    redirect_to conversation_path(receipt.conversation)
  end 
end
