class OrganizationSerializer < ActiveModel::Serializer
  attributes :id, :name, :website, :phone_number, :description, :address, :lat, :lng
end
