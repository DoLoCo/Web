# amount (Integer) the amount of the donation in cents
class Donation < ActiveRecord::Base
  STATUSES = {
    initiated: 'Initiated',
    pending: 'Pending',
    processed: 'Processed',
    failed: 'Failed'
  }

  belongs_to :user
  belongs_to :bank_account # user's BA, the to BA is derived from the campaign
  belongs_to :campaign

  validates :amount, numericality: { only_integer: true, greater_than: 0 }
  validates :bank_account_id, presence: true

  before_create :set_default_status

  def self.ordered
    order('donations.created_at DESC')
  end

  def self.pending
    where(status: STATUSES[:pending])    
  end

private

  def set_default_status
    self.status = STATUSES[:initiated]
  end

end
