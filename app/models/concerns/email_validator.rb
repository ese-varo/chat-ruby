class EmailValidator < ActiveModel::EachValidator
  EMAIL = /
  \A
  [A-Z0-9_.&%+\-']+   # mailbox
    @
  (?:[A-Z0-9\-]+\.)+  # subdomains
    (?:[A-Z]{2,25})     # TLD
  \z
  /ix

  def validate_each(record, attribute, value)
    return record.errors.add(attribute, "can't be blank") unless value
    return record.errors.add(attribute, 'should look like an email address') unless value =~ EMAIL
    record.errors.add(attribute, 'should not be longer than 100 chars') unless value.length <= 100
  end
end
