class CustomerSubscriptionSerializer
  include JSONAPI::Serializer
  attributes :status

  attribute :customer do |customer_sub|
    CustomerSerializer.new(customer_sub.customer)
  end
end
