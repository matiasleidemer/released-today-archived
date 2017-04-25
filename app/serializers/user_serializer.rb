class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :provider, :uid, :metadata
end
