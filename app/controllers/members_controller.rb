class MembersController < ApplicationController
  def index
    project_id = params[:project_id]
    @project = Project.find(project_id)
    @role = current_user.find_membership(project_id).role
    @invite = Invite.new
  end
end
