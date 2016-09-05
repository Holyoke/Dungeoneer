module Api::V1
  class ApiApplicationController < ActionController::API
    acts_as_token_authentication_handler_for User
    private
  end
end
