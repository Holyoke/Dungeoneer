class RegistrationsController < Devise::RegistrationsController
  after_action :invite_to_map, only: [:create], if: -> { params[:invite_token] }

  def new
    @token = params[:invite_token]
    super
  end

  def create
    super
  end

  private

  def invite_to_map
    invite = Invite.find_by_token(params[:invite_token])
    invite.recipient = resource
    invite.accept_invitation
  end
end
