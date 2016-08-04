class AreasController < ApplicationController
  before_filter :set_project

  def index
    @areas = @project.areas
  end

  # GET /areas/new
  def new
    @area = @project.areas.new
    render :new
  end

  def show
    @area = @project.areas.find(params[:id])
  end

  # GET /areas/1/edit
  def edit
    @area = @project.areas.find(params[:id])
  end

  # POST /areas
  # POST /areas.json
  def create
    @area = @project.areas.new(area_params)

    respond_to do |format|
      if @area.save
        format.html { redirect_to [@project, @area], notice: 'Area was successfully created.' }
        format.json { render :show, status: :created, location: @area }
      else
        format.html { render :new }
        format.json { render json: @area.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /areas/1
  # PATCH/PUT /areas/1.json
  def update
    @area = @project.areas.find(params[:id])

    respond_to do |format|
      if @area.update(area_params)
        format.html { redirect_to [@project, @area], notice: 'Area was successfully updated.' }
        format.json { render :show, status: :ok, location: @area }
      else
        format.html { render :edit }
        format.json { render json: @area.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /areas/1
  # DELETE /areas/1.json
  def destroy
    @area = @project.areas.find(params[:id])

    @area.destroy
    respond_to do |format|
      format.html { redirect_to project_path(@area.project), notice: 'Area was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_project
      if params.has_key?(:project_id)
        @project = Project.find(params[:project_id])
      else
        @project = Area.find(params[:id]).project
      end

      @project
    end

    def area_params
      params.require(:area).permit(:name, :floor_plan, :project_id)
    end
end
