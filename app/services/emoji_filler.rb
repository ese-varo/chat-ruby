require 'emoji/string_ext'

class EmojiFiller < ApplicationService
  INDEX = Emoji::Index.new.freeze
  def initialize(message)
    @message = message
  end

  def call
    fill_emojis
  end

  private

  def fill_emojis
    @message.content = find_emojis
    @message.save
  end

  def find_emojis
    @message.content.split.reduce('') do |res, elem|
      moji = INDEX.find_by_name(elem[1..-2])
      res += moji ? "#{moji['moji']} " : "#{elem} "
    end
  end
end
