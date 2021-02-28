class Conversation < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :participants, dependent: :destroy
  has_many :users, through: :participants

  VALID_STATUS = ['public', 'private']
  validates :status, presence: true, inclusion: { in: VALID_STATUS }

  scope :only_public, -> { where(status: 'public') }

  def public?
    status == 'public'
  end

  def current_user_not_in?(user)
    !users.include?(user)
  end

  def title
    name.blank? ? id : name
  end

  def number_of_messages
    messages.count
  end
end
