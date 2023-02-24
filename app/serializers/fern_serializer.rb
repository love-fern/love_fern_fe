class FernSerializer
  include JSONAPI::Serializer
  attributes :name, :shelf, :preferred_contact_method
end
