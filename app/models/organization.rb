class Organization < ActiveRecord::Base
  has_many :organization_admins
  has_many :admins, through: :organization_admins, class_name: 'User'
  has_many :bank_accounts, as: :ownable
  has_many :campaigns

  validates :name, presence: true
  validates :phone_number, presence: true
  validates :description, presence: true
  validates :address_line1, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :postal_code, presence: true

  def address
    address_parts = []

    address_parts << address_line1
    address_parts << address_line2
    address_parts << "#{city}, #{state} #{postal_code}"

    address_parts.join("\n")
  end
end
