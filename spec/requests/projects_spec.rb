require 'rails_helper'

 RSpec.describe "Projects", :type => :request do
   let(:user) { FactoryGirl.create(:user) }

   before do
     login_as(user, scope: :user)
   end

   describe "GET api/v1/projects" do
     it "returns all the projects" do
       FactoryGirl.create :project, name: 'Project-1'
       FactoryGirl.create :project, name: 'Project-2'

       get '/api/v1/projects'

       expect(response.status).to eq 200

       body = JSON.parse(response.body)
       project_names = body.map{|project| project['name'] }
       expect(project_names).to match_array(['Project-1', 'Project-2'])
     end
   end
end
