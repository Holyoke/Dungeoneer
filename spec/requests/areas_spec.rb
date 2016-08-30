require 'rails_helper'
require 'rspec_api_documentation/dsl'

 RSpec.describe "Areas", :type => :request do
   let(:user) { FactoryGirl.create(:user) }

   before do
     login_as(user, scope: :user)
   end

   describe "GET /api/v1/areas" do
     it "returns all the areas" do
       FactoryGirl.create :area, name: 'Area-1'
       FactoryGirl.create :area, name: 'Area-2'

       get '/api/v1/areas'

       expect(response.status).to eq 200

       body = JSON.parse(response.body)
       area_names = body.map{|area| area['name'] }
       expect(area_names).to match_array(['Area-1', 'Area-2'])
     end
   end

  #  describe "GET api/v1/areas/:id" do
  #    it "returns the specified area" do
  #      FactoryGirl.create :area, name: 'Area-X', id: 25
   #
  #      get '/api/v1/areas/25'
   #
  #      expect(response.status).to eq 200
   #
  #      body = JSON.parse(response.body)
  #      area_name = body['name']
  #      expect(area_name) == 'Area-X'
  #    end
  #  end
   #
  #  describe "POST /api/v1/areas" do
  #    it "creates the specified area" do
  #      area = {
  #        area: {
  #            name: "Area-Y"
  #          }
  #       }
   #
  #      post '/api/v1/areas',
  #        params: area.to_json,
  #        headers: { 'Content-Type': 'application/json' }
   #
  #      expect(response.status).to eq 201
   #
  #      body = JSON.parse(response.body)
   #
  #      area_name = body['name']
  #      expect(area_name) == 'Area-Y'
  #    end
  #  end
   #
  #  describe "PUT /api/v1/areas/:id" do
  #    it "updates the specified area" do
  #     FactoryGirl.create :area, name: 'Area-1', id: 1
   #
  #     area = {
  #       area: {
  #           name: "Area-X-Edited",
  #           description: "Testing the update for description"
  #         }
  #      }
   #
  #      put '/api/v1/areas/1',
  #        params: area.to_json,
  #        headers: { 'Content-Type': 'application/json' }
   #
  #      expect(response.status).to eq 200
   #
  #      body = JSON.parse(response.body)
   #
  #      expect(body['name']) == area[:area][:name]
  #      expect(body['description']) == area[:area][:decription]
  #    end
  #  end
   #
  #  describe "DELETE /api/v1/areas/:id" do
  #    it "deletes the specified area" do
  #      FactoryGirl.create :area, name: 'Area-1', id: 1
   #
  #      delete '/api/v1/areas/1'
   #
  #      expect(response.status).to eq 204
  #    end
  #  end

end
