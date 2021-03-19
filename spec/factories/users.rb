FactoryBot.define do
  factory :user do
    username { Faker::Internet.username(specifier: 4..9) }
    email { Faker::Internet.email }
    password { 'lapassword' }
    password_confirmation { 'lapassword' }
  end
end
