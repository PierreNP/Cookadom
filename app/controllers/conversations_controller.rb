class ConversationsController < ApplicationController
  def index
    @conversations = current_user.mailbox.conversations
    @empty = false
    @conversations.each do |conversation|
      @empty = true unless conversation.is_deleted?(current_user)
    end
  end




  def show
    @conversation = current_user.mailbox.conversations.find(params[:id])
    @conversation.recipients.each do |recipient|
      recipient.id == current_user.id ? @user = recipient : @interlocutor = recipient
    end
    @conversation.receipts_for(current_user).each do |receipt|
      receipt.message.mark_as_read(current_user)
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

  def destroy
    @conversation = current_user.mailbox.conversations.find(params[:id])
    @conversation.mark_as_deleted(current_user)
    redirect_back(fallback_location: root_path)

  end
end
