require 'rails_helper'

 RSpec.describe "Maps", :type => :request do
   let(:user) { FactoryGirl.create(:user) }

   before do
     login_as(user, scope: :user)
   end

   describe "GET /api/v1/maps" do
     it "returns all the maps" do
       FactoryGirl.create :map, name: 'Map-1', users: [user]
       FactoryGirl.create :map, name: 'Map-2', users: [user]

       get '/api/v1/maps'

       expect(response.status).to eq 200

       body = JSON.parse(response.body)
       map_names = body.map{|map| map['name'] }
       expect(map_names).to match_array(['Map-1', 'Map-2'])
     end
   end

   describe "GET api/v1/maps/:id" do
     it "returns the specified map" do
       FactoryGirl.create :map, name: 'Map-X', id: 25

       get '/api/v1/maps/25'

       expect(response.status).to eq 200

       body = JSON.parse(response.body)
       map_name = body['name']
       expect(map_name).to eq('Map-X')
     end
   end

   describe "POST /api/v1/maps" do
     it "creates the specified map" do
       map_params = {
         map: {
             name: "Map-Y"
           }
        }

       post '/api/v1/maps',
         params: map_params.to_json,
         headers: { 'Content-Type': 'application/json' }

       expect(response.status).to eq 201

       body = JSON.parse(response.body)

       map_name = body['name']
       expect(map_name).to eq(map_params[:map][:name])
     end
   end

   describe "PUT /api/v1/maps/:id" do
     it "updates the specified map" do
      FactoryGirl.create :map, name: 'Map-1', id: 1

      map_params = {
        map: {
            name: "Map-X-Edited",
            description: "Testing the update for description"
          }
       }

       put '/api/v1/maps/1',
         params: map_params.to_json,
         headers: { 'Content-Type': 'application/json' }

       expect(response.status).to eq 200

       body = JSON.parse(response.body)

       expect(body['name']).to eq(map_params[:map][:name])
       expect(body['description']).to eq(map_params[:map][:description])
     end
   end

   describe "DELETE /api/v1/maps/:id" do
     it "deletes the specified map" do
       FactoryGirl.create :map, name: 'Map-1', id: 1

       delete '/api/v1/maps/1'

       expect(response.status).to eq 204
     end
   end

end
