class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  def index
    @projects = current_user.projects
  end

  def show
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
      authorize @project
    end

    def project_params
      params.require(:project).permit(:name, :license, :description)
    end
end
