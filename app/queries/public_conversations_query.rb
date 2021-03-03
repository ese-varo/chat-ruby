class PublicConversationsQuery
  attr_reader :relation

  def initialize(relation = Conversation)
    @relation = relation
  end

  def self.call
    new.call
  end

  def call
    relation.where(status: 'public')
  end

  # def exclude(ids)
  #   where.not(id: ids)
  # end
end
