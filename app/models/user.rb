class User < ActiveRecord::Base
  has_secure_password

  validates :email, presence: true, 
                    uniqueness: true,
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password, presence: true, length: { minimum: 8 }
  validates :password_confirmation, presence: true
end
