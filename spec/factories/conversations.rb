FactoryBot.define do
  factory :conversation do
    association :participant
    name { Faker::Lorem.sentence(word_count: 3) }
    description { Faker::Lorem.paragraph }
    emoji { ':cat_face:' }
  end
end
