class RegistrationsController < Devise::RegistrationsController
  after_action :invite_to_project, only: [:create], if: -> { params[:invite_token] }

  def new
    @token = params[:invite_token]
    super
  end

  def create
    super
  end

  private

  def invite_to_project
    project = Invite.find_by_token(params[:invite_token]).project
    resource.projects.push(project)
  end
end
