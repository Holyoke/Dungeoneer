require 'acceptance_helper'

resource "Areas" do
  header "Accept", "application/json"
  header "Content-Type", "application/json"

  let!(:project) { FactoryGirl.create(:project_with_areas) }
  let(:user) { FactoryGirl.create(:user) }

  # before do
  #   login_as(user, scope: :user)
  # end

  get "/api/v1/areas" do
    parameter :project_id, "Specify project"
    let(:project_id) { project.id }

    let(:raw_post) { params.to_json }

    example_request "Getting a list of areas" do
      explanation "Retrieves a list of areas with project_id"
      expect(status).to eq 200
    end

  end

  get "api/v1/areas/:id" do
    let(:id) { project.areas.last.id }

    example_request "Retrieving a specific area" do
      explanation "Retrieve area by id"
      expect(status).to eq 200
    end
  end

  put "/api/v1/areas/:id" do
    parameter :name, "Name of area", :scope => :area
    parameter :description, "Description of the area", :scope => :area
    parameter :project_id, "id of the parent project", :scope => :area

    let(:id) { project.areas.last.id }
    let(:name) { "Updated area name." }
    let(:description) { "Updated area description." }
    let(:project_id) { project.id }

    let(:raw_post) { params.to_json }

    example_request "Update a specific area" do
      explanation "Updating an area by id. Requires project_id "
      expect(status).to eq 200
    end
  end
end
