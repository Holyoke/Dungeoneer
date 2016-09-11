require 'acceptance_helper'
require 'byebug'

resource "Api Sessions" do
  header "Accept", "application/json"
  header "Content-Type", "application/json"

  let(:user) { FactoryGirl.create(:user) }

  post "/api/v1/session" do
    parameter :email, 'User email', scope: :session
    parameter :password, 'User password', scope: :session

    let(:email) { user.email }
    let(:password) { 'password' }

    let(:raw_post) { params.to_json }

    let(:result) {
      { "email": user.email, "authentication_token": user.authentication_token, "id": user.id }
    }

    example_request "Logging in via query params" do
      expect(status).to eq 200
      response = JSON.parse(response_body)
      expect(response['email']).to eq(result[:email])
      expect(response['authentication_token']).to eq(result[:authentication_token])
      expect(response['id']).to eq(result[:id])
    end

  end
end
