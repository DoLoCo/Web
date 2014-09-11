class DonationSerializer < ActiveModel::Serializer
  attributes :id, :amount, :status, :actual_amount
end
