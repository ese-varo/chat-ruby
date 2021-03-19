FactoryBot.define do
  factory :message do
    association :user
    association :conversation
    content { Faker::Lorem.paragraph }
  end
end
