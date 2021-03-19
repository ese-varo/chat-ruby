FactoryBot.define do
  factory :participant do
    association :user
    association :conversation
  end
end
