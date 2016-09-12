require 'acceptance_helper'

resource "Pins" do
  header "Accept", "application/json"
  header "Content-Type", "application/json"

  let!(:user) { FactoryGirl.create(:user) }
  let!(:project) { FactoryGirl.create(:project_with_areas_and_pins, users: [user]) }
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

  get "api/v1/pin/:id" do
    let(:id) { area.id }

    example_request "Retrieving a specific pin" do
      explanation "Retrieve pin by id"
      expect(status).to eq 200
    end
  end
end
