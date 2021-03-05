class ConversationsQuery
  attr_reader :relation

  def initialize(relation = Conversation.all)
    @relation = relation.extending(Scopes)
  end

  def only_public
    relation.where(status: 'public')
  end

  def ordered
    relation.ordered_by_name
  end

  def public_more_active
    only_public.ordered_by_activity
  end

  module Scopes
    def ordered_by_name
      order(:name)
    end

    def ordered_by_activity
      includes(:messages)
        .order('messages.updated_at DESC')
    end
  end
end
