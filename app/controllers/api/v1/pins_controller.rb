module Api::V1
  class PinsController < ApiApplicationController
    before_action :set_pin, only: [:show, :update, :destroy]
    before_action :check_area, only: [:index]

    def index
      area = Area.find(params[:area_id])
      pins = area.pins
      render json: pins
    end

    def show
      render json: @pin
    end

    def create
      @pin = Pin.new(pin_params)

      if @pin.save
        render json: @pin, status: :created
      else
        render json: @pin.errors, status: :unprocessable_entity
      end
    end

    def update
      if @pin.update(pin_params)
        render json: @pin.to_json, status: 200
      else
        render json: @pin.errors, status: :unprocessable_entity
      end
    end

    def destroy
      @pin.destroy
      head 204
    end

    private

    def set_pin
      @pin = Pin.find(params[:id])
      authorize @pin
    end

    def pin_params
      params.require(:pin).permit(:x, :y, :description, :area_id)
    end

    def check_area
      if params[:area_id].nil?
        render json: {error: 'requires project_id'}, status: 404
      end
    end
  end
end
