class Conversation < ApplicationRecord
  has_many :messages
  has_many :participants
  has_many :users, through: :participants

  VALID_STATUS = ['public', 'private']
  validates :status, presence: true, inclusion: { in: VALID_STATUS }

  def private?
    status == 'private'
  end
end
