class TeaSerializer
  include JSONAPI::Serializer
  attributes :title, :description, :brew_time, :image_url
end
