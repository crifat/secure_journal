class ApplicationController < ActionController::API
  def authenticate_with_token!
    render json: { errors: "Not authenticated" },
           status: :unauthorized unless current_user.present?
  end
end
