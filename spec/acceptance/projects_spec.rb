require 'spec_helper'
require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "Projects" do
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
end
