module Api::V1
  class AreasController < ApiApplicationController
    before_action :set_area, only: [:show, :update, :destroy]
    before_action :check_map, only: [:index]

    def index
      map = Map.find(params[:map_id])
      @areas = map.areas
      render json: @areas
    end

    def show
      render json: @area
    end

    def create
      @area = area.new(area_params)

      if @area.save
        render json: @area, status: :created, location: @area
      else
        render json: @area.errors, status: :unprocessable_entity
      end
    end

    def update
      if @area.update(area_params)
        render json: @area
      else
        render json: @area.errors, status: :unprocessable_entity
      end
    end

    def destroy
      @area.destroy
    end

    private

    def set_area
      @area = Area.find(params[:id])
    end

    def area_params
      params.require(:area).permit(:name, :map_id, :description)
    end

    def check_map
      if params[:map_id].nil?
        render json: {error: 'requires map_id'}, status: 404
      end
    end
  end
end
