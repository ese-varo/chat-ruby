require 'rails_helper'

RSpec.describe Message do
  let(:user) { create(:user) }
  let(:conversation) { create(:conversation, messages: [message]) }
  let(:message) { create(:message, user: user) }
  describe "A valid Message" do
    it "has any text content" do
      message = conversation.messages.build(
        content: "Hello world!",
        user_id: user.id)
      expect(message).to be_valid
      message.update_attribute :content, "@#$%!@#^& 123hs rand ///hsl"
      expect(message.errors[:content]).to be_empty
    end

    it "can not have an attached image" do
    end
    it "can have an attached image" do
    end
  end

  describe "An invalid Message" do
    it "has no text content" do
      message = conversation.messages.build(user_id: user.id)
      message.valid?
      expect(message.errors[:content]).to include("can't be blank")
    end
  end

  it "lets me change its text content" do
    previous_content = message.content
    message.update_attribute :content, "I'm already different"
    expect(message.content).not_to eq previous_content
  end

  it "lets me change its attached image" do
  end
  it "lets me remove its attached image" do
  end

  it "returns a date string" do
    message.save
    expect(message.date).to be_a_kind_of String
  end
end
