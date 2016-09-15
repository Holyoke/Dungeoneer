class PinPolicy < ApplicationPolicy
  def destroy?
    project_id = record.area.project.id
    user.project_memberships.find(project_id).admin?
  end

  def update?

  end
end
