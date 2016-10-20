class MembersController < ApplicationController
  def index
    map_membership = current_user.find_membership(params[:map_id])
    if map_membership.nil?
      flash[:alert] = "Unauthorized Access"
      redirect_to '/'
    else
      @map = map_membership.map
      @role = map_membership.role
      @invite = Invite.new
    end
  end
end
