require 'rails_helper'

describe Conversation do
  before :each do
    @alejandro = User.create(
      username: 'alejandro',
      email: 'alejandro@gmail.com',
      password: 'alejandro',
      password_confirmation: 'alejandro')
    @conversation = @alejandro.conversations.create(
      name: 'The conversation',
      description: 'Lets talk about rails apps',
      emoji: ':dog_face:')
  end

  it "is valid if has name, description, emoji and participants" do
    eduardo = User.create(
      username: 'eleduardo',
      email: 'eleduardo@gmail.com',
      password: 'eleduardo',
      password_confirmation: 'eleduardo')
    @conversation.users << eduardo
    expect(@conversation.users).to include(@alejandro, eduardo)
    expect(@conversation).to be_valid
  end

  it "is invalid if has no name" do
    @conversation.update_attribute :name, ''
    expect(@conversation).not_to be_valid
  end

  it "is invalid if has no description" do
    @conversation.update_attribute :description, ''
    expect(@conversation).not_to be_valid
  end

  it "is invalid if has no emoji" do
    @conversation.update_attribute :emoji, ''
    expect(@conversation).not_to be_valid
  end

  it "can have just one participant" do
    participants = @conversation.users
    @conversation.users.delete(participants)
    expect(@conversation.users).to be_empty
    @conversation.users << @alejandro
    expect(@conversation.users).to include @alejandro
  end

  it "lets me change its name" do
    @conversation.update_attribute :name, 'Conversation 2.0'
    expect(@conversation).to be_valid
  end

  it "lets me change its description" do
    @conversation.update_attribute :description, 'Another time'
    expect(@conversation).to be_valid
  end

  it "lets me change its emoji" do
    @conversation.update_attribute :emoji, "❤"
    expect(@conversation).to be_valid
  end

  it "can be private" do
    @conversation.update_attribute :status, 'private'
    expect(@conversation).to be_valid
  end

  it "can be public" do
    @conversation.update_attribute :status, 'public'
    expect(@conversation).to be_valid
  end

  it "lets me know if its status is public" do
    @conversation.update_attribute :status, 'private'
    expect(@conversation.public?).not_to be_truthy
  end
end
