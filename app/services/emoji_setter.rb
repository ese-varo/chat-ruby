class EmojiSetter < ApplicationService
  EMOJI_TEXT = /[:][a-z|_]+[:]/
  def initialize(text)
    @text = text
  end

  def call
    set_emoji
    EmojiFiller.call(@text)
    return unless @text.content.match(EMOJI_TEXT)
    @text.content = ':heart:'
    EmojiFiller.call(@text)
    raise Conversation::DefaultEmoji
  end

  def set_emoji
    index = @text.content =~ EMOJI_TEXT
    @text.content = @text.content[index..-1].split[0]
  end
end
