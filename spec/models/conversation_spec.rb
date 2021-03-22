require 'rails_helper'

describe Conversation do
  let(:user) { create(:user, conversations: [conversation]) }
  let(:conversation) { create(:conversation) }

  it "is valid if has name, description, emoji and participants" do
    second_user = create(:user)
    conversation.users << second_user
    expect(conversation.users).to include(user, second_user)
    expect(conversation).to be_valid
  end

  it "is invalid if has no name" do
    conversation.update_attribute :name, nil
    expect(conversation).not_to be_valid
  end

  it "is invalid if has no description" do
    conversation.update_attribute :description, nil
    expect(conversation).not_to be_valid
  end

  it "is invalid if has no emoji" do
    conversation.update_attribute :emoji, nil
    expect(conversation).not_to be_valid
  end

  it "can have just one participant" do
    participants = conversation.users
    conversation.users.delete(participants)
    expect(conversation.users).to be_empty
    conversation.users << user
    expect(conversation.users).to include user
  end

  it "lets me change its name" do
    conversation.update_attribute :name, Faker::Lorem.sentence
    expect(conversation).to be_valid
  end

  it "lets me change its description" do
    conversation.update_attribute :description, Faker::Lorem.paragraph
    expect(conversation).to be_valid
  end

  it "lets me change its emoji" do
    conversation.update_attribute :emoji, Faker::Lorem.multibyte
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
