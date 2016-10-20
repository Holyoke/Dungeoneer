class PinPolicy < ApplicationPolicy

  def show?
    return false if record.area.nil? || record.area.map.nil?
    map_id = record.area.map.id

    #assumes at least collaborator if added
    user.map_memberships.find_by_map_id(map_id).present?
  end

  def destroy?
    return false if record.area.nil? || record.area.map.nil?
    map_id = record.area.map.id

    user.map_memberships.find_by_map_id(map_id).admin?
  end

  def update?
    return false if record.area.nil? || record.area.map.nil?
    map_id = record.area.map.id

    user.map_memberships.find_by_map_id(map_id).admin?
  end

  class Scope < Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

    def resolve
      user.maps
    end
  end #Scope
end
