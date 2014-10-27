class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :first_name, :last_name, :score, :image_url
end
