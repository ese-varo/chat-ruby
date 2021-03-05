class Conversation < ApplicationRecord
  class DefaultEmoji < StandardError
  end

  include ActiveModel::Validations
  has_many :messages, dependent: :destroy
  has_many :participants, dependent: :destroy
  has_many :users, through: :participants

  VALID_STATUS = ['public', 'private']
  validates :status, inclusion: { in: VALID_STATUS }
  validates :name, :description, :status, presence: true

  validates :emoji, emoji: true

  scope :exclude, ->(ids) { where.not(id: ids) }

  def content
    emoji
  end

  def content=(value)
    self.emoji = value
  end

  def public?
    status == 'public'
  end

  def title
    name.blank? ? id : name
  end
end
