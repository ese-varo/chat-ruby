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

  def public_more_active(num = 5)
    time_range = (Time.now.midnight - 1.month)..Time.now
    only_public.ordered_by_activity(time_range).limit(num)
  end

  module Scopes
    def ordered_by_name
      order(:name)
    end

    def ordered_by_activity(time_range)
      includes(:messages)
        .where(messages: { created_at: time_range })
        .order('messages.updated_at DESC')
    end
  end
end
