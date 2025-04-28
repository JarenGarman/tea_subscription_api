FactoryBot.define do
  factory :customer_subscription do
    customer { nil }
    subscription { nil }
    status { "MyString" }
    frequency { 1 }
  end
end
