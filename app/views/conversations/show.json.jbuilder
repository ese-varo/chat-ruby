json.array! @conversation.messages do |message|
  json.id message.id
  json.username message.username
  json.removed? message.removed?
  if message.removed?
    json.content 'This message was removed'
  else
    json.content message.content
  end
  json.date message.date
end
