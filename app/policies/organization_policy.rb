class OrganizationPolicy < Struct.new(:user, :organization)
  class Scope < Struct.new(:user, :scope)
    def resolve
      scope
    end
  end

  def permitted_attributes
    [:name, :website, :phone_number, :description, :address_line1, :address_line2, :city, :state, :postal_code]
  end

  def update?
    organization.is_admin?(user.id)
  end

  def destroy?
    organization.is_admin?(user.id)
  end

  def show?
    organization.is_admin?(user.id)
  end

end
