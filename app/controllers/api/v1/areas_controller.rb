module Api::V1
  class AreasController < ActionController::API
    before_action :set_area, only: [:show, :update, :destroy]

    def index
      project = Project.find(params[:project_id])
      @areas = project.areas
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
        params.require(:area).permit(:name, :floor_plan, :project_id, :description)
      end
  end
end
