class BankAccountPolicy < Struct.new(:user, :bank_account)
  def permitted_attributes
    #[:bank_account_name, :account_number, :account_type, :routing_number]
    [:bank_account_name, :last_four, :instrument_href]
  end

  def update?
    is_user_permitted?
  end

  def destroy?
    is_user_permitted?
  end

private
  
  def is_user_permitted?
    if bank_account.ownable_type == BankAccount::OWNABLE_TYPES[:user]
      ownable.id == user.id
    elsif bank_account.ownable_type == BankAccount::OWNABLE_TYPES[:organization]
      bank_account.ownable.is_admin?(user.id)
    end
  end

end