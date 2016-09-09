class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :authorize_update, only: [:edit, :update, :destroy]

  def index
    @project_memberships = current_user.project_memberships
  end

  def show
    membership = current_user.find_membership(@project.id)
    @role = membership.role
    @invite = Invite.new
  end

  def new
    @project = Project.new
  end

  def edit
  end

  def create
    project = Project.new(project_params)
    project.users << current_user

    if project.save
      current_user.set_role(project.id, "admin")
      redirect_to project, notice: 'Project was successfully created.'
    else
      render :new
    end
  end

  def update
    if @project.update(project_params)
      redirect_to @project, notice: 'Project was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @project.destroy
    redirect_to projects_url, notice: 'Project was successfully destroyed.'
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name, :license, :description)
  end

  def authorize_update
    if !current_user.projects.include?(@project) || !current_user.admin?(@project.id)
      flash[:alert] = "Unauthorized access to this project"
      redirect_to '/'
    end
  end
end
