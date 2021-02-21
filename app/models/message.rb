class Message < ApplicationRecord
  belongs_to :user
  belongs_to :conversation

  def remove
    self.removed = true
    self.content = ''
  end

  def removed?
    self.removed
  end

  def date
    self.created_at.strftime "%a %b-%d %H:%M"
  end
end
