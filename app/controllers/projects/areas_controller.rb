class Projects::AreasController < ApplicationController
    def index
      @areas = Area.all
    end

    # GET /areas/new
    def new
      @area = Area.new
    end
end
