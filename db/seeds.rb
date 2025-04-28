require "factory_bot_rails"
require "database_cleaner/active_record"

prng = Random.new

customers = FactoryBot.create_list(:customer, 10)
teas = FactoryBot.create_list(:tea, 10)
subscriptions = FactoryBot.create_list(:subscription, 10)

subscriptions.each do |sub|
  teas.sample(prng.rand(3..7)).each do |tea|
    FactoryBot.create(:subscription_tea, tea: tea, subscription: sub)
  end

  customers.sample(prng.rand(3..10)).each do |customer|
    FactoryBot.create(:customer_subscription, customer: customer, subscription: sub)
  end
end
