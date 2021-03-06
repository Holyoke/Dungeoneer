module Api::V1
  class SessionsController < ActionController::API

    # This controller provides a JSON version of the Devise::SessionsController and
    # is compatible with the use of SimpleTokenAuthentication.
    # See https://github.com/gonzalo-bulnes/simple_token_authentication/issues/27

    def create
      # Fetch params
      email = params[:session][:email] if params[:session]
      password = params[:session][:password] if params[:session]
      id = User.find_by(email: email).try(:id) if email.presence

      # Validations
      if request.format != :json
        render status: 406, json: { message: 'The request must be JSON.' }
        return
      end

      if email.nil? or password.nil?
        render status: 400, json: { message: 'The request MUST contain the user email and password.' }
        return
      end

      # Authentication
      user = User.find_by(email: email)

      if user
        if user.valid_password? password
          user.restore_authentication_token!

          render status: 200, json: { email: user.email, authentication_token: user.authentication_token, id: id }
        else
          render status: 401, json: { message: 'Invalid email or password.' }
        end
      else
        render status: 401, json: { message: 'Invalid email or password.' }
      end
    end

    def destroy
      # Fetch params
      user = User.find_by(authentication_token: params[:authentication_token])

      if user.nil?
        render status: 404, json: { message: 'Invalid token.' }
      else
        user.authentication_token = nil
        user.save!
        render status: 204, json: nil
      end
    end
  end
end
