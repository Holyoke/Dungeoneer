class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def after_sign_up_path_for(resource)
    "/users/#{current_user.id}/projects"
  end

  def after_sign_in_path_for(resource)
    "/users/#{current_user.id}/projects"
  end

  private

  def user_not_authorized
    flash[:alert] = "Access denied."
    redirect_to (request.referrer || root_path)
  end
end
