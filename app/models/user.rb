class User < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :participants
  has_many :conversations, through: :participants, dependent: :destroy

  scope :ordered, -> { order('username') }
  def shared_conversations_with(participant)
    conversations.where(id: shared_conversation_ids(participant)).compact
  end

  acts_as_authentic do |c|
    c.crypto_provider = Authlogic::CryptoProviders::BCrypt
  end

  def shared_conversation_ids(participant)
    conversations.ids.collect do |id|
      id if participant.conversations.ids.include?(id)
    end.compact
  end

  USERNAME = /\A[a-zA-Z0-9_][a-zA-Z0-9\.+\-_@ ]+\z/

  validates :email, email: true
  validates_uniqueness_of :email, message: 'is already taken'

  validates :username,
    format: {
      with: USERNAME,
      message: "should use only letters and numbers."
    },
    length: { within: 3..100 },
    uniqueness: {
      case_sensitive: false,
      if: :will_save_change_to_username?
    }

  validates :password,
    confirmation: { if: :require_password? },
    length: {
      minimum: 8,
      if: :require_password?
    }
  validates :password_confirmation,
    length: {
      minimum: 8,
      if: :require_password?
  }
end
