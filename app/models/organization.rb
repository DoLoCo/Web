class Organization < ActiveRecord::Base
  has_many :organization_admins
  has_many :admins, through: :organization_admins, class_name: 'User', source: :user
  has_many :bank_accounts, as: :ownable
  has_many :campaigns

  # a hack to get if the address changed when update is called and we want to know after the fact
  before_update :address_changed?

  validates :name, presence: true
  validates :phone_number, presence: true
  validates :description, presence: true
  validates :address_line1, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :postal_code, presence: true

  def address
    return @address if defined?(@address)

    address_parts = []

    address_parts << address_line1
    address_parts << address_line2 unless address_line2.blank?
    address_parts << "#{city}, #{state} #{postal_code}"

    @address = address_parts.join("\n").strip
  end

  def is_admin?(user_id)
    admins.where(users: { id: user.id }).exists?
  end

  def address_changed?
    return @address_changed if defined?(@address_changed)

    @address_changed = address_line1_changed? ||
                       address_line2_changed? ||
                       city_changed? ||
                       state_changed? ||
                       postal_code_changed?
  end
end
