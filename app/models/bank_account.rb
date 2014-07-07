class BankAccount < ActiveRecord::Base
  # Statuses
  #------------
  # unverified: Verification has not been sent via gateway
  # verification_created: Verification has been sent via gateway, waiting response
  # verification_failed: Verification failed
  # verified: Successfully verified and ready to use
  # inactive: User has removed this account (removed from gateway, keep meta record for book keeping)
  STATUSES = {
    unverified: 'Unverified',
    verification_created: 'Verification Created',
    verification_failed: 'Verification Failed',
    verified: 'Verified',
    inactive: 'Inactive'
  }

  attr_accessor :account_number, :account_type, :bank_name, :routing_number

  belongs_to :ownable, polymorphic: true

  has_many :campaigns
  has_many :donations

  validates :nickname, presence: true

  before_create :set_default_status

private

  def set_default_status
    self.status = STATUSES[:unverified]
  end
end
