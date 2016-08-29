class ProjectPolicy < ApplicationPolicy

  def update?
    user.admin? || user.collaborator? || record.user == user
  end

  def destroy?
    user.admin?? || record.user == user
  end

  def edit?
    user.admin? || user.collaborator? || record.user == user
  end
end
