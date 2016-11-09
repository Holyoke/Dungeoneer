class MapsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_map, only: [:show, :edit, :update, :destroy]
  before_action :authorize_update, only: [:edit, :update, :destroy]

  def index
    @map_memberships = current_user.map_memberships
  end

  def show
    membership = current_user.find_membership(@map.id)
    @role = membership.role
  end

  def new
    @map = Map.new
  end

  def edit
  end

  def create
    map = Map.new(map_params)
    map.users << current_user

    if map.save
      current_user.set_role(map.id, "admin")
      redirect_to map, notice: 'Map was successfully created.'
    else
      render :new
    end
  end

  def update
    if @map.update(map_params)
      redirect_to @map, notice: 'Map was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @map.destroy
    redirect_to maps_url, notice: 'Map was successfully destroyed.'
  end

  private

  def set_map
    @map = Map.find(params[:id])
  end

  def map_params
    params.require(:map).permit(:name, :description)
  end

  def authorize_update
    if !current_user.maps.pluck(:id).include?(@map.id) || !current_user.admin?(@map.id)
      flash[:alert] = "Unauthorized access to this map"
      redirect_to '/'
    end
  end
end
