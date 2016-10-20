module Api::V1
    class MapsController < ApiApplicationController
      before_action :set_map, only: [:show, :update, :destroy]

      def index
        @maps = current_user.maps
        render json: @maps, include: ['areas']
      end

      def show
        render json: @map, serializer: MapSerializer
      end

      def create
        @map = Map.new(map_params)

        if @map.save
          render json: @map, status: :created, location: @map
        else
          render json: @map.errors, status: :unprocessable_entity
        end
      end

      def update
        if @map.update(map_params)
          render json: @map
        else
          render json: @map.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @map.destroy
      end

      private
        def set_map
          @map = Map.find(params[:id])
        end

        def map_params
          params.require(:map).permit(:name, :license, :description)
        end
    end
end
