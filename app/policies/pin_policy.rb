class PinPolicy < ApplicationPolicy

  def show?
    return false if record.area.nil? || record.area.project.nil?
    project_id = record.area.project.id

    #assumes at least collaborator if added
    user.project_memberships.find_by_project_id(project_id).present?
  end

  def destroy?
    return false if record.area.nil? || record.area.project.nil?
    project_id = record.area.project.id

    user.project_memberships.find_by_project_id(project_id).admin?
  end

  def update?
    return false if record.area.nil? || record.area.project.nil?
    project_id = record.area.project.id

    user.project_memberships.find_by_project_id(project_id).admin?
  end

  class Scope < Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

    def resolve
      user.projects
    end
  end #Scope
end
