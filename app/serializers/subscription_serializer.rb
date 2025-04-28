class SubscriptionSerializer
  include JSONAPI::Serializer
  attributes :title, :price, :image_url

  has_many :teas
end
