class MembersController < ApplicationController
  def index
    project_membership = current_user.find_membership(params[:project_id])
    if project_membership.nil?
      flash[:alert] = "Unauthorized Access"
      redirect_to '/'
    else
      @project = project_membership.project
      @role = project_membership.role
      @invite = Invite.new
    end
  end
end
