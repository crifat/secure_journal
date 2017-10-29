class SessionsController < ApplicationController
  def create
    @result = Session::Create.(params)
    render json: @result['presenter.default'], status: @result['response.status']
  end

  def destroy
    user = User.find_by(auth_token: params[:id])
    user.generate_authentication_token!
    user.save
    head 204
  end
end
