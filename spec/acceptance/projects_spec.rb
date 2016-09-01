require 'spec_helper'
require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "Projects" do
  header "Accept", "application/json"
  header "Content-Type", "application/json"

  let(:user) { FactoryGirl.create(:user) }

  before do
    login_as(user, scope: :user)
  end

  # get "/api/v1/projects" do
  #   example_request "Listing projects" do
  #     explanation "List all the projects"
  #     expect(status).to eq 200
  #   end
  # end
  #
  # get "api/v1/projects/:id" do
  #   let!(:project) { FactoryGirl.create :project, name: 'Project-X', id: 25 }
  #   let(:id) { project.id }
  #
  #   example_request "Retrieving a specific project" do
  #     explanation "Retrieve project by id"
  #     expect(status).to eq 200
  #   end
  # end

  put "/api/v1/projects/:id" do
    parameter :name, "Name of project", :scope => :project
    parameter :license, "Optional license", :scope => :project
    parameter :description, "Description of the project", :scope => :project

    let!(:project) { FactoryGirl.create :project, name: 'Project-X', id: 25 }
    let(:id) { project.id }
    let(:name) { "Updated name" }
    let(:description { "Updated description"})

    let(:raw_post) { params.to_json }

    example_request "Update a specific project" do
      explanation "Updating a project by id"
      expect(status).to eq 200
    end
  end

end
