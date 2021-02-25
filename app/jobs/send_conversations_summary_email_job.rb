class SendConversationsSummaryEmailJob < ApplicationJob
  self.queue_adapter = :async
  queue_as :default

  def perform(user)
    @user = user
    # reschedule_job(user)

    ConversationMailer.conversations_summary(user, summary).deliver_later
  end

  private
  def summary
    { conversations: new_conversations.count, messages: messages }
  end

  def new_conversations
    @new_conversations ||= @user.conversation.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
  end

  def new_messages_count
    today = Date.today
    messages = 0
    @user.conversations.each do |c|
      c.messages.reverse.each { |m| m.created_at.to_date < today ? break : messages += 1 }
      # messages += c.messages.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
    end
    messages
  end

  def reschedule_job
    # self.class.set(wait: 24.hours).perform_later(user)
    self.class.set(wait: 10.seconds).perform_later(@user)
  end
end
