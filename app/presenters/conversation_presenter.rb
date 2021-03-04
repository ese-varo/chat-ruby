class ConversationPresenter
  def initialize(conversation)
    @conversation = conversation
  end

  def title
    @conversation.name.blank? ? @conversation.id : @conversation.name
  end

  def number_of_messages
    @conversation.messages.count
  end

  def id
    @conversation.id
  end

  def users
    @conversation.users
  end

  def status
    @conversation.status
  end

  def description
    @conversation.description
  end

  def emoji
    @conversation.emoji
  end

  def participants_list(username)
    list = @conversation.users.sample(3).collect do |user|
      username == user.username ? 'you' : user.username
    end.join(', ')
    return list if @conversation.users.count < 4
    list += '...'
  end
end
