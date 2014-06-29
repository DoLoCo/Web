class OrganizationGeocodingWorker
  include Sidekiq::Worker

  def perform(organization_id)
    organization = Organization.find(organization_id)

    coordinates = Geocoder.coordinates(organization.address)

    organization.lat = coordinates.first
    organization.lng = coordinates.last

    organization.save
  end

end