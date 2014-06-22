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

private

  def set_default_status
    self.status = STATUSES[:active]
  end
end
