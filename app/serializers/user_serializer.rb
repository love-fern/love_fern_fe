class UserSerializer
  include JSONAPI::Serializer
  attributes :google_id, :name, :email
end
