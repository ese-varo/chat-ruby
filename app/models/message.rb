require 'emoji/string_ext'

class Message < ApplicationRecord
  belongs_to :user
  belongs_to :conversation

  has_one_attached :image

  INDEX = Emoji::Index.new.freeze

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

  def username
    self.user.username
  end

  def fill_emojis
    self.content = find_emojis
    self.save
  end

  def find_emojis
    self.content.split.reduce('') do |res, elem|
      if elem.match(/[:][a-z|_]+[:]/)
        moji = INDEX.find_by_name(elem[1..-2])
        moji ? res += "#{moji['moji']} " : res += "#{elem} "
      else
        res += "#{elem} "
      end
    end
  end
end
