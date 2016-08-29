module Api::V1
  class ProjectsController < ActionController::API
    before_action :set_project, only: [:show, :update, :destroy]

    def index
      @projects = Project.includes(:areas)
      render json: @projects, include: ['areas']
    end

    def show
      render json: @project, serializer: ProjectSerializer
    end

    def create
      @project = Project.new(project_params)

      if @project.save
        render json: @project, status: :created, location: @project
      else
        render json: @project.errors, status: :unprocessable_entity
      end
    end

    def update
      if @project.update(project_params)
        render json: @project
      else
        render json: @project.errors, status: :unprocessable_entity
      end
    end

    def destroy
      @project.destroy
    end

    private
      def set_project
        @project = Project.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def project_params
        params.require(:project).permit(:name, :license, :description)
      end
  end
end
