class InvitesController < ApplicationController

  def create
    invite = Invite.new(invite_params)
    invite.sender_id = current_user.id
    if invite.save
      InviteMailer.new_user_invite(
        invite,
        new_user_registration_path(invite_token: invite.token)
      ).deliver

      redirect_to "/"
    end
  end

  private

  def invite_params
    params.require(:invite).permit(:project_id, :email)
  end
end
