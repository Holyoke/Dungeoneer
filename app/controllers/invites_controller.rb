class InvitesController < ApplicationController

  def create
    invite = Invite.new(invite_params)
    invite.sender_id = current_user.id
    if invite.save
      #send a mail thing
    end

  end

  private

  def invite_params
    params.require(:invite).permit(:project_id, :email)
  end
end
