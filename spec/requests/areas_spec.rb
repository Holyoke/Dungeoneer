require 'rails_helper'
require 'rspec_api_documentation/dsl'

 RSpec.describe "Areas", :type => :request do
   let(:user) { FactoryGirl.create(:user) }
   let!(:project) { FactoryGirl.create(:project_with_areas, id: 1) }

   before do
     login_as(user, scope: :user)
   end

   describe "GET /api/v1/areas" do
     it "returns all the areas of a specified project" do
       get '/api/v1/areas', params: { project_id: 1}

       expect(response.status).to eq 200

       body = JSON.parse(response.body)
       result_names = project.areas.map{ |area| area['name'] }
       area_names = body.map{|area| area['name'] }
       expect(area_names).to match_array(area_names)
     end

     it "returns an error message if there's no project_id specified" do
       get '/api/v1/areas'
       expect(response.status).to eq 404
     end
   end

   describe "GET api/v1/areas/:id" do
     it "returns the specified area" do
       area = project.areas.first

       get "/api/v1/areas/#{area.id}"

       expect(response.status).to eq 200

       body = JSON.parse(response.body)
       area_name = body['name']
       expect(area_name).to eq(area_name)
     end
   end

   describe "PUT /api/v1/areas/:id" do
     it "updates the specified area" do
      area = project.areas.first
      area_params = {
        area: {
            name: "Area-X-Edited",
            description: "Updated description"
          }
       }

       put "/api/v1/areas/#{area.id}",
         params: area_params.to_json,
         headers: { 'Content-Type': 'application/json' }

       expect(response.status).to eq 200

       body = JSON.parse(response.body)

       expect(body['name']).to eq(area_params[:area][:name])
       expect(body['description']).to eq(area_params[:area][:description])
     end
   end
end
