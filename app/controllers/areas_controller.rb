class AreasController < ApplicationController
  before_action :set_area, only: [:show, :edit, :update, :destroy]
  before_action :authorize_update, only: [:show, :edit, :update, :destroy]

  def index
    @areas = @project.areas
  end

  # GET project/:id/areas/new
  def new
    project = Project.find(params[:project_id])
    @area = project.areas.new
    render :new
  end

  def show
  end

  # GET /areas/1/edit
  def edit
  end

  # POST /areas
  def create
    project = Project.find(area_params[:project_id])
    @area = project.areas.new(area_params)
    if @area.save
      redirect_to @area, notice: 'Area was successfully created.'
    else
      flash.now[:errors] = @areas.errors.full_messages
      render :new
    end
  end

  # PATCH/PUT /areas/1
  def update
    if @area.update(area_params)
      redirect_to @area, notice: 'Area was successfully updated.'
    else
      flash.now[:errors] = @area.errors.full_messages
      render :edit
    end
  end

  # DELETE /areas/1
  def destroy
    if @area.destroy
      redirect_to project_path(@area.project), notice: 'Area was successfully destroyed.'
    end
  end

  private

  def set_area
    @area = Area.find(params[:id])
  end

  def area_params
    params.require(:area).permit(:name, :floor_plan, :project_id, :description)
  end

  def authorize_update
    project = @area.project
    #potential query optimization
    if !current_user.projects.include?(project) || !current_user.admin?(project.id)
      flash[:alert] = "Unauthorized access to this project"
      redirect_to '/'
    end
  end
end
