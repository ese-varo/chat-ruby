require 'rails_helper'

RSpec.describe Message do
  let(:user) { create(:user) }
  let(:conversation) { create(:conversation, messages: [message]) }
  let(:message) { create(:message, user: user) }
  describe "A valid Message" do
    it "has any text content" do
      second_message = build(:message, user: user, conversation: conversation)
      expect(second_message).to be_valid
      message.update_attribute :content, Faker::Lorem.sentence
      expect(message.errors[:content]).to be_empty
    end
  end

  describe "An invalid Message" do
    it "has no text content" do
      second_message = build(:message, conversation: conversation, user: user,
                             content: nil)
      second_message.valid?
      expect(second_message.errors[:content]).to include("can't be blank")
    end
  end

  it "lets me change its text content" do
    previous_content = message.content
    message.update_attribute :content, Faker::Lorem.sentence
    expect(message.content).not_to eq previous_content
  end

  it "returns a date string" do
    message.save
    expect(message.date).to be_a_kind_of String
  end
end
