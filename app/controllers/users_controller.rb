class UsersController < ApplicationController
  # before_action :authenticate_with_token!, only: [:update, :destroy]

  respond_to :json

  def index
    @users = User.all
    respond_with @users
  end

  def show
    respond_with User.find(params[:id])
  end

  def create
    @result = User::Create.(params)
    render json: @result['presenter.default'], status: @result['response.status']
  end

  def update
    user = current_user

    if user.update(user_params)
      render json: user, status: 200
    else
      render json: { errors: user.errors }, status: 422
    end
  end

  def destroy
    current_user.destroy
    head 204
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

end