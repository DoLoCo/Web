class BankAccountSerializer < ActiveModel::Serializer
  attributes :id, :bank_account_name, :last_four, :status
end
