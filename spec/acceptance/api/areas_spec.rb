require 'acceptance_helper'

resource "Areas" do
  header "Accept", "application/json"
  header "Content-Type", "application/json"

  let!(:user) { FactoryGirl.create(:user) }
  let!(:map) { FactoryGirl.create(:map_with_areas, users: [user]) }

  before do
    login_as(user, scope: :user)
  end

  get "/api/v1/areas" do
    parameter :map_id, "Specify map"
    let(:map_id) { map.id }

    let(:raw_post) { params.to_json }

    example_request "Getting a list of areas" do
      explanation "Retrieves a list of areas with map_id"

      result_names = map.areas.map{ |area| area['name'] }
      result_widths = map.areas.map{ |area| area['width'] }

      response = JSON.parse(response_body)

      area_names = response.map{|area| area['name'] }
      area_widths = response.map{|area| area['width'] }

      expect(area_names).to match_array(result_names)
      expect(area_widths).to match_array(result_widths)

      expect(status).to eq 200
    end
  end

  get "api/v1/areas/:id" do
    let(:id) { map.areas.last.id }

    example_request "Retrieving a specific area" do
      explanation "Retrieve area by id"

      response = JSON.parse(response_body)
      width = response['width']

      expect(status).to eq 200
      expect(map.areas.last.width).to eq(width)
    end
  end

  put "/api/v1/areas/:id" do
    parameter :name, "Name of area", :scope => :area
    parameter :description, "Description of the area", :scope => :area
    parameter :map_id, "id of the parent map", :scope => :area

    response_field :name, "Name of area", :scope => :area
    response_field :description, "Description of the area", :scope => :area
    response_field :map_id, "id of the parent map", :scope => :area

    let(:id) { map.areas.last.id }
    let(:name) { "Updated area name." }
    let(:description) { "Updated area description." }
    let(:map_id) { map.id }

    let(:raw_post) { params.to_json }

    example_request "Update a specific area" do
      explanation "Updating an area by id. Requires map_id "
      expect(status).to eq 200
    end
  end
end
