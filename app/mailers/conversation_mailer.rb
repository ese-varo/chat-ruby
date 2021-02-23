class ConversationMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def new_conversation_email(user)
    @user = user
    mail(to: user.email, subject: "New conversation")
  end

  def new_message_email(user, conversation)
    @user = user
    @conversation = conversation
    mail(to: user.email, subject: "New message")
  end

  def conversations_summary(user, summary = {})
    @user = user
    @summary = summary
    mail(to: user.email, subject: "Conversations summary")
  end
end
