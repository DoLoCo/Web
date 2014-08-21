# amount (Integer) the amount of the donation in cents
class Donation < ActiveRecord::Base
  belongs_to :user
  belongs_to :bank_account # user's BA, the to BA is derived from the campaign
  belongs_to :campaign

  validates :amount, numericality: { only_integer: true, greater_than: 0 }
  validates :bank_account_id, presence: true

  def self.ordered
    order('donations.created_at DESC')
  end
end
