module Api::V1
  class ProjectsController < ActionController::API
    def index
      render json: "Success Test"
    end
  end
end
