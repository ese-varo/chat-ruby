FactoryBot.define do
  factory :user do
    username { Faker::Internet.username(specifier: 4..9) }
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 8) }
    password_confirmation { password }
  end
end
