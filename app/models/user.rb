class User < ApplicationRecord
  has_many :messages
  has_many :conversations, :through => :participants

  acts_as_authentic do |c|
    c.crypto_provider = Authlogic::CryptoProviders::Sha512
  end

  EMAIL = /
    \A
    [A-Z0-9_.&%+\-']+   # mailbox
    @
    (?:[A-Z0-9\-]+\.)+  # subdomains
    (?:[A-Z]{2,25})     # TLD
    \z
  /ix
  USERNAME = /\A[a-zA-Z0-9_][a-zA-Z0-9\.+\-_@ ]+\z/

  validates :email,
    format: {
      with: EMAIL,
      message: "should look like an email address."
    },
    length: { maximum: 100 },
    uniqueness: {
      case_sensitive: false,
      if: :will_save_change_to_email?
    }

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
