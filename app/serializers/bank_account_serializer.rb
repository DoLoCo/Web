class BankAccountSerializer < ActiveModel::Serializer
  attributes :id, :nickname, :status
end
