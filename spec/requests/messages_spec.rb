require 'rails_helper'

RSpec.describe 'Messages', type: :request do
  let(:user) { create(:user) }
  let(:conversation) { create(:conversation, users: [user]) }
  let(:message) { build(:message, conversation: conversation, user: user) }

  before(:example) do
    post user_sessions_path, params: { user_session: { 
      username: user.username, password: user.password
    } }
  end

  it 'creates a message correctly' do
    message_valid_params = { 
      message: { content: message.content, conversation_id: message.conversation_id, user_id: message.user_id } }
    post "/conversations/#{conversation.id}/messages.js", params: message_valid_params
    expect(response).to have_http_status(200)
  end

  it "can't create a message with invalid data" do
    message_invalid_params = { 
      message: { content: nil, conversation_id: nil, user_id: nil } }
    post "/conversations/#{conversation.id}/messages.js", params: message_invalid_params
    expect(response).to redirect_to(conversation)
  end

  it "can't edit a non existent message" do
    get "/conversations/#{conversation.id}/messages/3/edit"
    expect(response).not_to have_http_status(200)
  end
end
