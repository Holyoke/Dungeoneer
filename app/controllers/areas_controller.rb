class AreasController < ApplicationController
  before_action :set_area, only: [:show, :edit, :update, :destroy]
  before_action :authorize_update, only: [:show, :edit, :update, :destroy]

  # GET map/:id/areas/new
  def new
    map = Map.find(params[:map_id])
    @area = map.areas.new
    render :new
  end

  def show
  end

  # GET /areas/1/edit
  def edit
  end

  # POST /areas
  def create
    map = Map.find(area_params[:map_id])
    @area = map.areas.new(area_params)
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
      redirect_to map_path(@area.map), notice: 'Area was successfully destroyed.'
    end
  end

  private

  def set_area
    @area = Area.find(params[:id])
  end

  def area_params
    params.require(:area).permit(:name, :floor_plan, :map_id, :description)
  end

  def authorize_update
    map = @area.map
    #potential query optimization
    if !current_user.maps.include?(map) || !current_user.admin?(map.id)
      flash[:alert] = "Unauthorized access to this map"
      redirect_to '/'
    end
  end
end
