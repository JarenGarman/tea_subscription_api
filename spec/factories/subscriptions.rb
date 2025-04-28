FactoryBot.define do
  factory :subscription do
    title { Faker::Lorem.word }
    price { Faker::Commerce.price }
    image_url { Faker::LoremFlickr.image }
  end
end
