module UsersHelper
def notification
    if current_user
        current_user.mailbox.conversations.all.each do |conversation|
            @unread = 0
            conversation.receipts_for(current_user).each do |receipt|
            @unread += 1 unless receipt.is_read?
            end
        end
    end
end

end
