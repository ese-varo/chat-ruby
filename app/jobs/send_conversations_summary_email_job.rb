class SendConversationsSummaryEmailJob < ApplicationJob
  self.queue_adapter = :async
  queue_as :default

  def perform(user)
    # reschedule_job(user)

    send_summary(user)
  end

  def send_summary(user)
    conversations = new_conversations(user)
    messages = new_messages(conversations)
    ConversationMailer.conversations_summary(user, conversations: conversations.count, messages: messages).deliver_later
  end

  private

  def new_conversations(user)
    conversations = []
    user.conversations.reverse.each do |conversation|
      break if conversation.created_at.to_date < Date.today
      conversations << conversation
    end
    conversations
  end

  def new_messages(conversations)
    today = Date.today
    messages = 0
    conversations.each do |c|
      c.messages.reverse.each { |m| m.created_at.to_date < today ? break : messages += 1 }
    end
    messages
  end

  def reschedule_job(user)
    # self.class.set(wait: 24.hours).perform_later(user)
    self.class.set(wait: 10.seconds).perform_later(user)
  end
end
