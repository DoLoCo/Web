class OrganizationSerializer < ActiveModel::Serializer
  attributes :id, :name, :website, :phone_number, :description, :address, :lat, :lng, :image_url

  has_many :organization_admins

end
