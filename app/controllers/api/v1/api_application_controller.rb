module Api::V1
  class ApiApplicationController < ActionController::API
    acts_as_token_authentication_handler_for User

    include Pundit
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    private
    def user_not_authorized
      render json: { error: "You are not authorized to perform this action." }, status: 401
    end
  end
end
