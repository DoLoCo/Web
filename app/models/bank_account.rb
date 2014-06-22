class BankAccount < ActiveRecord::Base
  STATUSES = {
    :active => 'Active',
    :not_active => 'Not Active' # user removed this, still need it for book keeping
  }

  belongs_to :ownable, polymorphic: true

  has_many :campaigns

  validates :nickname, presence: true

  before_create :set_default_status

private

  def set_default_status
    self.status = STATUSES[:active]
  end
end
