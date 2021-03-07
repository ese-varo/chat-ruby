class ConversationPresenter
  attr_reader :conversation
  delegate :id,
           :name,
           :users,
           :status,
           :description,
           :emoji,
           :messages,
           to: :conversation

  def initialize(conversation)
    @conversation = conversation
  end

  def title
    name.blank? ? id : name
  end

  def number_of_messages
    messages.count
  end

  def participants_list(username)
    list = users.sample(3).collect do |user|
      username == user.username ? 'you' : user.username
    end.join(', ')
    return list if users.count < 4
    list += '...'
  end
end
