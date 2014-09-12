class CampaignSerializer < ActiveModel::Serializer
  attributes :id, :organization_id, :bank_account_id, :title, :description, :status, :target_amount, :target_date, :donations_amount_sum

  has_one :organization

  # TODO: add bank_account_id if admin of campaign's organization
=begin
  def filter(keys)
    keys.delete :bank_account_id if scope.nil? && !object.organization.is_admin?(scope.id)
    keys
  end
=end
end
