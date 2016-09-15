class PinPolicy < ApplicationPolicy

  def show?
    true
  end

  def destroy?
    return false if record.area.nil?

    project_id = record.area.project.id
    return false if project_id.nil?
    user.project_memberships.find_by_project_id(project_id).admin?
  end

  def update?
    true
  end
end
