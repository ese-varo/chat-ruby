json.array! @conversation.messages do |message|
  json.username message.username
  if message.removed?
    json.content 'This message was removed'
  else
    json.content message.content
  end
  json.id message.id
  json.date message.date
end
