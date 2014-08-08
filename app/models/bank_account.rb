class BankAccount < ActiveRecord::Base
  OWNABLE_TYPES = {
    user: 'User',
    organization: 'Organization'
  }

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

  attr_accessor :account_number, :account_type, :routing_number

  belongs_to :ownable, polymorphic: true

  has_many :campaigns
  has_many :donations

  validates :bank_account_name, presence: true
  validates :last_four, presence: true
  validates :gateway_reference_id, presence: true, on: :create

  before_create :set_default_status

  def self.verified
    where(status: STATUSES[:verified])
  end

  def unverified?
    status == STATUSES[:unverified]
  end

  def verification_created!
    update_attribute(:status, STATUSES[:verification_created])
  end

  def destroy
    update_attribute(:status, STATUSES[:inactive])
  end

private

  def set_default_status
    self.status = STATUSES[:unverified]
  end
end
