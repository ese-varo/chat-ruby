class MessageObserver < ActiveRecord::Observer
  def after_create(message)
    message.conversation.users.each do |user|
      next if user == message.user
      ConversationMailer.new_message_email(user, message.conversation).deliver_now
    end
  end
end
