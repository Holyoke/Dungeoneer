require 'acceptance_helper'

resource "Floorplan Pins" do
  header "Accept", "application/json"
  header "Content-Type", "application/json"

  let!(:user) { FactoryGirl.create(:user) }
  let!(:project) { FactoryGirl.create(:project, :with_area_and_pins, users: [user]) }
  let!(:area) { project.areas.first }

  before do
    login_as(user, scope: :user)
  end

  get "/api/v1/pins" do
    parameter :area_id, "Gets pins for a specified area"
    let(:area_id) { area.id }

    let(:raw_post) { params.to_json }

    example_request "Getting a list of pins" do
      explanation "Retrieves a list of pins with area_id"
      expect(status).to eq 200
    end
  end

  get "/api/v1/pins/:id" do
    let(:id) { area.pins.last.id }

    example_request "Retrieving a specific pin" do
      explanation "Retrieve pin by id"
      expect(status).to eq 200
    end
  end

  post "/api/v1/pins/" do
    parameter :x, "X coordinate in terms of percentage. Data format is float, and ranges between 0 -> 1.0.", :scope => :pin
    parameter :y, "Y coordinate in terms of percentage. Data format is float, and ranges between 0 -> 1.0.", :scope => :pin
    parameter :area_id, "ID of the area which the pin belongs to", :scope => :area

    let(:x) { "Updated area name." }
    let(:y) { "Updated area description." }
    let(:area_id) { area.id }

    let(:raw_post) { params.to_json }

    example_request "Adding a pin" do
      explanation "Updating an area by id. Requires project_id"
    end
  end
end
