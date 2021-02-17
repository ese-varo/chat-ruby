class Conversation < ApplicationRecord
  VALID_STATUS = ['public', 'private']
  validates :status, presence: true, inclusion: { in: VALID_STATUS }

  def private?
    status == 'private'
  end
end
