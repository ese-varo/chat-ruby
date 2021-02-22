# Preview all emails at http://localhost:3000/rails/mailers/conversation_mailer
class ConversationMailerPreview < ActionMailer::Preview
  def new_conversation_mail_preview
    ConversationMailer.new_conversation_email(User.first)
  end

  def new_message_email_preview
    ConversationMailer.new_message_email(User.first)
    # ConversationMailer.new_message_email(user)
  end
end
