class User < ActiveRecord::Base
  has_secure_password

  has_many :bank_accounts, as: :ownable
  has_many :organization_admins
  has_many :organizations, through: :organization_admins
  has_many :donations

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, 
                    uniqueness: { if: :check_email_uniqueness },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password, presence: true, 
                       length: { minimum: 8 }, 
                       confirmation: true,
                       if: :check_password_requirements
  validates :password_confirmation, presence: true, if: :check_password_requirements

private

  def check_email_uniqueness
    new_record? || email_changed?
  end

  def check_password_requirements
    new_record? || !password.blank?
  end
end
