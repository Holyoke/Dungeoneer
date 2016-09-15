require 'acceptance_helper'

resource "Areas" do
  header "Accept", "application/json"
  header "Content-Type", "application/json"

  let!(:user) { FactoryGirl.create(:user) }
  let!(:project) { FactoryGirl.create(:project_with_areas, users: [user]) }

  before do
    login_as(user, scope: :user)
  end

  get "/api/v1/areas" do
    parameter :project_id, "Specify project"
    let(:project_id) { project.id }

    let(:raw_post) { params.to_json }

    example_request "Getting a list of areas" do
      explanation "Retrieves a list of areas with project_id"

      result_names = project.areas.map{ |area| area['name'] }
      result_widths = project.areas.map{ |area| area['width'] }

      response = JSON.parse(response_body)

      area_names = response.map{|area| area['name'] }
      area_widths = response.map{|area| area['width'] }

      expect(area_names).to match_array(result_names)
      expect(area_widths).to match_array(result_widths)

      expect(status).to eq 200
    end
  end

  get "api/v1/areas/:id" do
    let(:id) { project.areas.last.id }

    example_request "Retrieving a specific area" do
      explanation "Retrieve area by id"

      response = JSON.parse(response_body)
      width = response['width']

      expect(status).to eq 200
      expect(project.areas.last.width).to eq(width)
    end
  end

  put "/api/v1/areas/:id" do
    parameter :name, "Name of area", :scope => :area
    parameter :description, "Description of the area", :scope => :area
    parameter :project_id, "id of the parent project", :scope => :area

    response_field :name, "Name of area", :scope => :area
    response_field :description, "Description of the area", :scope => :area
    response_field :project_id, "id of the parent project", :scope => :area

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
