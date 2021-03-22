require 'emoji/string_ext'

class EmojiFiller < ApplicationService
  INDEX = Emoji::Index.new.freeze
  def initialize(text)
    @text = text
  end

  def call
    fill_emojis
  end

  private

  def fill_emojis
    @text.content = find_emojis
    @text.save
  end

  def find_emojis
    @text.content.to_s.split.reduce('') do |res, elem|
      moji = INDEX.find_by_name(elem[1..-2])
      res += moji ? "#{moji['moji']} " : "#{elem} "
    end
  end
end
