class CampaignPolicy

  def initialize(user, campaign)
    @user = user
    @campaign = campaign
  end

  def permitted_attributes
    [ :organization_id, :bank_account_id, :title, :description, :target_amount, :target_date ]
  end

  def create?
    organization.is_admin?(user.id)
  end

  def update?
    organization.is_admin?(user.id)
  end

  def destroy?
    organization.is_admin?(user.id)
  end

private

  def organization
    @organization ||= campaign.organization
  end

end