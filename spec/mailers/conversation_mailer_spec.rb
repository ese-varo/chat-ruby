require "rails_helper"

RSpec.describe ConversationMailer, type: :mailer do
  let(:user) { create(:user) }
  let(:conversation) { create(:conversation, users: [user],
    messages: [create(:message)]) }

  describe "new_conversation_email" do
    let(:mail) { ConversationMailer.new_conversation_email(user) }

    it "renders the email" do
      expect(mail.subject).to eq("New conversation")
      expect(mail.to).to eq([user.email])
      expect(mail.body.encoded).to match(/You've been added to a new conversation/)
    end
  end

  describe "new_message_email" do
    let(:mail) { ConversationMailer.new_message_email(user, conversation) }

    it "renders the email" do
      expect(mail.subject).to eq("New message")
      expect(mail.to).to eq([user.email])
      expect(mail.body.encoded).to match(/You have a new message at conversation/)
    end
  end

  describe "conversation_summary" do
    let(:mail) { ConversationMailer.conversations_summary(user) }

    it "renders the email" do
      expect(mail.subject).to eq("Conversations summary")
      expect(mail.to).to eq([user.email])
      expect(mail.body.encoded).to match(/This is the summary of the day:/)
    end
  end
end
