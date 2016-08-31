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

  get "/api/v1/projects" do
    example_request "Listing projects" do
      explanation "List all the projects"
      expect(status).to eq 200
    end
  end

  get "api/v1/projects/:id" do
    let!(:project) { FactoryGirl.create :project, name: 'Project-X', id: 25 }
    let(:id) { project.id }

    example_request "Retrieving a specific project" do
      explanation "Retrieve project by id"
      expect(status).to eq 200
    end
  end

  put "/api/v1/projects/:id" do
    let!(:project) { FactoryGirl.create :project, name: 'Project-X', id: 25 }
    let(:id) { project.id }

    parameter :name, "Name of order", :scope => :order
    parameter :paid, "If the order has been paid for", :scope => :order
    parameter :email, "Email of user that placed the order", :scope => :order

    example_request "Update a specific project" do
      explanation "Updating a project by id"

      expect(status).to eq 200
    end
  end
end
