require 'rails_helper'

 RSpec.describe "Projects", :type => :request do
   let(:user) { FactoryGirl.create(:user) }

   before do
     login_as(user, scope: :user)
   end

   describe "GET /api/v1/projects" do
     it "returns all the projects" do
       FactoryGirl.create :project, name: 'Project-1', users: [user]
       FactoryGirl.create :project, name: 'Project-2', users: [user]

       get '/api/v1/projects'

       expect(response.status).to eq 200

       body = JSON.parse(response.body)
       project_names = body.map{|project| project['name'] }
       expect(project_names).to match_array(['Project-1', 'Project-2'])
     end
   end

   describe "GET api/v1/projects/:id" do
     it "returns the specified project" do
       FactoryGirl.create :project, name: 'Project-X', id: 25

       get '/api/v1/projects/25'

       expect(response.status).to eq 200

       body = JSON.parse(response.body)
       project_name = body['name']
       expect(project_name).to eq('Project-X')
     end
   end

   describe "POST /api/v1/projects" do
     it "creates the specified project" do
       project_params = {
         project: {
             name: "Project-Y"
           }
        }

       post '/api/v1/projects',
         params: project_params.to_json,
         headers: { 'Content-Type': 'application/json' }

       expect(response.status).to eq 201

       body = JSON.parse(response.body)

       project_name = body['name']
       expect(project_name).to eq(project_params[:project][:name])
     end
   end

   describe "PUT /api/v1/projects/:id" do
     it "updates the specified project" do
      FactoryGirl.create :project, name: 'Project-1', id: 1

      project_params = {
        project: {
            name: "Project-X-Edited",
            description: "Testing the update for description"
          }
       }

       put '/api/v1/projects/1',
         params: project_params.to_json,
         headers: { 'Content-Type': 'application/json' }

       expect(response.status).to eq 200

       body = JSON.parse(response.body)

       expect(body['name']).to eq(project_params[:project][:name])
       expect(body['description']).to eq(project_params[:project][:description])
     end
   end

   describe "DELETE /api/v1/projects/:id" do
     it "deletes the specified project" do
       FactoryGirl.create :project, name: 'Project-1', id: 1

       delete '/api/v1/projects/1'

       expect(response.status).to eq 204
     end
   end

end
