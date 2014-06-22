class BankAccount < ActiveRecord::Base
  belongs_to :ownable, polymorphic: true

  has_many :campaigns

  validates :nickname, presence: true
end
