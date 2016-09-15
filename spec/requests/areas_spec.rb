require 'rails_helper'

 RSpec.describe "Areas", :type => :request do
   let!(:user) { FactoryGirl.create(:user) }
   let!(:project) { FactoryGirl.create(:project_with_areas, users: [user]) }

   before do
     login_as(user, scope: :user)
   end

   describe "GET /api/v1/areas" do
     it "returns all the areas of a specified project" do
       get '/api/v1/areas', params: { project_id: 1}

       expect(response.status).to eq 200

       body = JSON.parse(response.body)
       result_names = project.areas.map{ |area| area['name'] }
       result_widths = project.areas.map{ |area| area['width'] }

       area_names = body.map{|area| area['name'] }
       area_widths = body.map{|area| area['width'] }

       expect(area_names).to match_array(result_names)
       expect(area_widths).to match_array(result_widths)
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
       area_width = body['width']
       expect(area_name).to eq(area.name)
       expect(area_width).to eq(area.width)
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
