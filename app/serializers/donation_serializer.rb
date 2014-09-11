class DonationSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :amount, :status, :actual_amount

  has_one :user
end
