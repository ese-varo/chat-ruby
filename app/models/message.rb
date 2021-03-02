class Message < ApplicationRecord
  belongs_to :user
  belongs_to :conversation

  delegate :username, to: :user
  has_one_attached :image

  def removed?
    removed
  end

  def date
    created_at.strftime "%a %b-%d %H:%M"
  end
end
