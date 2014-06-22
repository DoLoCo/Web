class BankAccount < ActiveRecord::Base
  belongs_to :ownable, polymorphic: true

  validates :nickname, presence: true
end
