class Organization < ActiveRecord::Base
  has_many :organization_admins
  has_many :admins, through: :organization_admins, class_name: 'User'

  validates :name, presence: true
  validates :phone_number, presence: true
  validates :description, presence: true
  validates :address_line1, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :postal_code, presence: true
end
