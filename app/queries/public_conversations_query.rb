class PublicConversationsQuery
  def self.call(relation = Conversation)
    relation.where(status: 'public')
  end
end
