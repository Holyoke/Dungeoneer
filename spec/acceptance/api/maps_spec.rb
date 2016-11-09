require 'acceptance_helper'

resource "Maps" do
  header "Accept", "application/json"
  header "Content-Type", "application/json"

  let!(:user) { FactoryGirl.create(:user) }
  let!(:maps) { FactoryGirl.create_list(:map_with_areas, 2, users: [user]) }

  before do
    login_as(user, scope: :user)
  end

  get "/api/v1/maps" do
    example_request "Getting a list of maps" do
      explanation "Retrieves a list of maps with areas"
      expect(status).to eq 200
    end
  end

  get "api/v1/maps/:id" do
    let(:id) { maps.first.id }

    example_request "Retrieving a specific map" do
      explanation "Retrieve map by id"
      expect(status).to eq 200
    end
  end

  put "/api/v1/maps/:id" do
    parameter :name, "Name of map", :scope => :map
    parameter :license, "Optional license", :scope => :map
    parameter :description, "Description of the map", :scope => :map

    let(:id) { maps.last.id }
    let(:name) { "Updated name." }
    let(:description) { "Updated description." }
    let(:raw_post) { params.to_json }

    example_request "Update a specific map" do
      explanation "Updating a map by id"
      expect(status).to eq 200
    end
  end
end
