FactoryBot.define do
  factory :customer_subscription do
    customer
    subscription
    status { ["active", "inactive"].sample }
    frequency { [1, 3, 6, 12].sample }
  end
end
