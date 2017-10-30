class SessionsController < ApplicationController
  def create
    @result = Session::Create.(params)
    render json: @result['presenter.default'], status: @result['response.status']
  end

  def destroy
    @result = Session::Destroy.(params, 'current_user' => current_user)
    head 204
  end
end
