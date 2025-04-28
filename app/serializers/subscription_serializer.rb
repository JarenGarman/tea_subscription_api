class SubscriptionSerializer
  include JSONAPI::Serializer
  attributes :title, :price, :image_url

  attribute :customer_subscriptions do |sub|
    CustomerSubscriptionSerializer.new(sub.customer_subscriptions)
  end

  has_many :teas
end
