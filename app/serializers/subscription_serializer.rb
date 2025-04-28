class SubscriptionSerializer
  include JSONAPI::Serializer
  attributes :title, :price, :image_url
end
