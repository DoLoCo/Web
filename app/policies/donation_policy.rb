class DonationPolicy < Struct.new(:user, :donation)
  def permitted_attributes
    [:amount, :bank_account_id]
  end

  def create?
    user.bank_accounts.verified.where(id: donation.bank_account_id).exists?
  end
end