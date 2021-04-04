require 'rails_helper'

RSpec.describe 'Conversations', type: :request do
  let(:user) { create(:user) }
  let(:conversation) { create(:conversation, users: [user]) }

  before(:example) do
    post user_sessions_path, params: { user_session: { 
      username: user.username, password: user.password
    } }
  end

  it 'deletes a conversation' do
    delete "/conversations/#{conversation.id}.js"
    expect(response).to have_http_status(200)
  end


  it "can't delete a non existent conversatino" do
    delete "/conversations/3.js"
    expect(response).not_to have_http_status(200)
  end
end
