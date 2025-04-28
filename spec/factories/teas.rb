FactoryBot.define do
  factory :tea do
    title { Faker::Tea.variety }
    description { Faker::Lorem.paragraph }
    brew_time { Faker::Number.between(from: 3, to: 10) }
    image_url { Faker::LoremFlickr.image }
  end
end
