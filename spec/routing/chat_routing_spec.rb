require 'rails_helper'

RSpec.describe 'chat routing', :aggregate_failures, type: :routing do
  it 'routes conversations' do
    expect(get: '/').to route_to(controller: 'pages', action: 'index')
    expect(post: '/conversations').to route_to(
      controller: 'conversations', action: 'create')
    expect(get: '/conversations/new').to route_to(
      controller: 'conversations', action: 'new')
    expect(get: '/conversations/1').to route_to(
      controller: 'conversations', action: 'show', id: '1')
    expect(get: '/conversations/1/edit').to route_to(
      controller: 'conversations', action: 'edit', id: '1')
    expect(patch: '/conversations/1').to route_to(
      controller: 'conversations', action: 'update', id: '1')
    expect(delete: '/conversations/1').to route_to(
      controller: 'conversations', action: 'destroy', id: '1')
    expect(get: '/start_conversation').to route_to(
      controller: 'conversations', action: 'start_conversation')
    expect(get: '/join_conversation').to route_to(
      controller: 'conversations', action: 'join')
    expect(get: '/shared_conversation').to route_to(
      controller: 'conversations', action: 'shared_conversation')
    expect(get: '/profile/1').to route_to(
      controller: 'conversations', action: 'profile', id: '1')
  end

  it 'routes messages' do
    expect(post: '/conversations/1/messages').to route_to(
      controller: 'messages', action: 'create', conversation_id: '1')
    expect(get: '/conversations/1/messages/1/edit').to route_to(
      controller: 'messages', action: 'edit', id: '1', conversation_id: '1')
    expect(patch: '/conversations/1/messages/1').to route_to(
      controller: 'messages', action: 'update', id: '1', conversation_id: '1')
    expect(delete: '/conversations/1/messages/1').to route_to(
      controller: 'messages', action: 'destroy', id: '1', conversation_id: '1')
  end
end
