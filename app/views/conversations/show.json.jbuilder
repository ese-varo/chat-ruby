json.array! @conversation.messages do |message|
  json.id message.id
  json.conversation_id @conversation.id
  json.current_user message.user == current_user
  json.username message.username
  json.removed message.removed?
  if message.removed?
    json.content 'This message was removed'
  else
    json.content message.content
  end
  json.date message.date
end
