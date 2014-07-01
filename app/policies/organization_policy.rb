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
    is_organization_admin?
  end

  def destroy?
    is_organization_admin?
  end

private

  def is_organization_admin?
    organization.admins.where(users: { id: user.id }).exists?
  end

end
