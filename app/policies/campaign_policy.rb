class CampaignPolicy

  attr_reader :organization

  def initialize(user, campaign)
    @user = user
    @campaign = campaign
    @organization = @campaign.organization if @campaign.respond_to?(:organization)
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

end