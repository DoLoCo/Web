# Status 
# target_amount (Integer) The target amount for the campaign in cents
# target_date (Date)
class Campaign < ActiveRecord::Base
  STATUSES = {
    :active => 'Active',
    :complete => 'Complete'
  }

  belongs_to :organization
  belongs_to :bank_account

  has_many :donations

  validates :title, presence: true
  validates :description, presence: true

  before_create :set_default_status

  def self.by_distance_from_coordinates(lat, lng, distance=5, units='mi')
    distance = distance / 0.62137 if units == 'mi'
    includes(:organization).references(:organization)
      .where('calculate_distance(organizations.lat, organizations.lng, ?, ?) <= ?', lat, lng, distance)
  end

  def self.by_organization_id(organization_id)
    where(organization_id: organization_id)
  end

private

  def set_default_status
    self.status = STATUSES[:active]
  end
end
