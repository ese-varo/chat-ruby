class Conversation < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :participants, dependent: :destroy
  has_many :users, through: :participants

  VALID_STATUS = ['public', 'private']
  validates :status, presence: true, inclusion: { in: VALID_STATUS }

  def public?
    status == 'public'
  end

  def current_user_not_in?(user)
    !self.users.include?(user)
  end
end
