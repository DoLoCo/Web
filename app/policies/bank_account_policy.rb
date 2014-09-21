class BankAccountPolicy < Struct.new(:user, :bank_account)
  def permitted_attributes
    [:instrument_href]
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
      bank_account.ownable.id == user.id
    elsif bank_account.ownable_type == BankAccount::OWNABLE_TYPES[:organization]
      bank_account.ownable.is_admin?(user.id)
    end
  end

end
