require 'emoji'
require 'emoji/string_ext'

INDEX = Emoji::Index.new.freeze
@content = 'hola este es un :heart: y :dog:'
def fill_emojis
  @content = find_emojis
end

def find_emojis
  @content.split.reduce('') do |res, elem|
    if elem.match(/[:][a-z|_]+[:]/)
      moji = INDEX.find_by_name(elem[1..-2])
      moji ? res += "#{elem[1..-2].image_url} " : res += "#{elem} "
    else
      res += "#{elem} "
    end
  end
end

puts fill_emojis
