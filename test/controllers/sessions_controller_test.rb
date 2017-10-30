require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    #TODO Need to move to the test helper
    @user = User::Create.(user: {email: "user-#{SecureRandom.hex(4)}@gmail.com", password: '12345678', password_confirmation: '12345678'})['model']
    puts @user.auth_token
  end

  test "login user and respond with tokens" do
    post login_url(session: {email: @user.email, password: '12345678'}), as: :json
    assert_equal JSON.parse(response.body)['auth_token'], @user.reload.auth_token

    assert_response 201
  end

  test "logout user " do
    previous_token = @user.auth_token
    delete logout_url, headers: { 'Authorization' => @user.auth_token }, as: :json
    assert_not_equal previous_token, @user.reload.auth_token
    assert_response 204
  end
end
