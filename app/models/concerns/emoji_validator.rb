class EmojiValidator < ActiveModel::EachValidator
  VALID_EMOJIS = /[\u{1f600}-\u{1f64f}]|[\u{1f300}-\u{1f5ff}]|[\u{2500}-\u{2BEF}]|[\u{2702}-\u{27b0}]|[:][a-z|_]+[:]/
  def validate_each(record, attribute, value)
    record.errors.add(attribute,
      'should look like an emoji text input, e.g. :an_emoji:') unless value =~ VALID_EMOJIS
  end
end
