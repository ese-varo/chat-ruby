require 'emoji/string_ext'

class Message < ApplicationRecord
  belongs_to :user
  belongs_to :conversation

  delegate :username, to: :user
  has_one_attached :image

  INDEX = Emoji::Index.new.freeze

  def remove
    self.removed = true
    # image.purge
    self.content = ''
  end

  def removed?
    removed
  end

  def date
    created_at.strftime "%a %b-%d %H:%M"
  end

  def fill_emojis
    self.content = find_emojis
    save
  end

  def find_emojis
    content.split.reduce('') do |res, elem|
      moji = INDEX.find_by_name(elem[1..-2])
      res += moji ? "#{moji['moji']} " : "#{elem} "
    end
  end
end
