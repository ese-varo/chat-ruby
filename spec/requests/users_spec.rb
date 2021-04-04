require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let(:user) { create(:user) }

  before(:example) do
    post user_sessions_path, params: { user_session: { 
      username: user.username, password: user.password
    } }
  end

  it 'returns the current user' do
    get edit_user_path(user)
    expect(response).to have_http_status(:success)
  end
end
