class User < ActiveRecord::Base
  has_secure_password

  has_many :organization_admins
  has_many :organizations, through: :organization_admins

  validates :email, presence: true, 
                    uniqueness: true,
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password, presence: true, length: { minimum: 8 }
  validates :password_confirmation, presence: true
end
