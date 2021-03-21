require 'rails_helper'

describe Conversation do
  let(:alejandro) { create(:user, username: 'alejandro',
    conversations: [conversation]) }
  let(:conversation) { create(:conversation) }

  it "is valid if has name, description, emoji and participants" do
    eduardo = create(:user, username: 'eduardo')
    conversation.users << eduardo
    expect(conversation.users).to include(alejandro, eduardo)
    expect(conversation).to be_valid
  end

  it "is invalid if has no name" do
    conversation.update_attribute :name, ''
    expect(conversation).not_to be_valid
  end

  it "is invalid if has no description" do
    conversation.update_attribute :description, ''
    expect(conversation).not_to be_valid
  end

  it "is invalid if has no emoji" do
    conversation.update_attribute :emoji, ''
    expect(conversation).not_to be_valid
  end

  it "can have just one participant" do
    participants = conversation.users
    conversation.users.delete(participants)
    expect(conversation.users).to be_empty
    conversation.users << alejandro
    expect(conversation.users).to include alejandro
  end

  it "lets me change its name" do
    conversation.update_attribute :name, 'Conversation 2.0'
    expect(conversation).to be_valid
  end

  it "lets me change its description" do
    conversation.update_attribute :description, 'Another time'
    expect(conversation).to be_valid
  end

  it "lets me change its emoji" do
    conversation.update_attribute :emoji, "❤"
    expect(conversation).to be_valid
  end

  it "can be private" do
    conversation.update_attribute :status, 'private'
    expect(conversation).to be_valid
  end

  it "can be public" do
    conversation.update_attribute :status, 'public'
    expect(conversation).to be_valid
  end

  it "lets me know if its status is public" do
    conversation.update_attribute :status, 'private'
    expect(conversation).not_to be_public
  end
end
