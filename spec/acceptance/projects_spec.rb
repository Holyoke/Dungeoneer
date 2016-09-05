require 'acceptance_helper'

resource "Projects" do
  header "Accept", "application/json"
  header "Content-Type", "application/json"

  let!(:projects) { FactoryGirl.create_list(:project, 2) }
  let(:user) { FactoryGirl.create(:user) }

  before do
    login_as(user, scope: :user)
  end

  get "/api/v1/projects" do
    example_request "Getting a list of projects" do
      explanation "Retrieves a list of projects with areas"
      expect(status).to eq 200
    end
  end

  get "api/v1/projects/:id" do
    let(:id) { projects.first.id }

    example_request "Retrieving a specific project" do
      explanation "Retrieve project by id"
      expect(status).to eq 200
    end
  end

  put "/api/v1/projects/:id" do
    parameter :name, "Name of project", :scope => :project
    parameter :license, "Optional license", :scope => :project
    parameter :description, "Description of the project", :scope => :project

    let(:id) { projects.last.id }
    let(:name) { "Updated name." }
    let(:description) { "Updated description." }
    let(:license) { "updatedLicense1" }
    let(:raw_post) { params.to_json }

    example_request "Update a specific project" do
      explanation "Updating a project by id"
      expect(status).to eq 200
    end
  end
end
