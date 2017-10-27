require 'test_helper'

class DiariesControllerTest < ActionDispatch::IntegrationTest
  setup do
    #TODO need to move to the test helper
    @user = User::Create.(user: {email: "user-#{SecureRandom.hex(4)}@gmail.com", password: '121345678', password_confirmation: '12345678'})['model']
    @diary = Diary::Create.({diary: {name: 'Test Diary', user_id: @user.id}})['model']
    puts @diary.user_id
  end

  test "should get index" do
    get diaries_url, headers: { 'Authorization' => @user.auth_token }, as: :json
    assert_response :success
  end

  test "should create diary" do
    assert_difference('Diary.count') do
      post diaries_url, params: { diary: { name: @diary.name, user_id: @diary.user_id } }, headers: { 'Authorization' => @user.auth_token }, as: :json
    end

    assert_response 201
  end

  test "should show diary" do
    get diary_url(id: @diary.id), headers: { 'Authorization' => @user.auth_token }, as: :json
    assert_response :success
  end

  test "should update diary" do
    patch diary_url(@diary), params: { diary: { name: @diary.name, user_id: @diary.user_id } }, headers: { 'Authorization' => @user.auth_token }, as: :json
    assert_response 200
  end

  test "should destroy diary" do
    assert_difference('Diary.count', -1) do
      delete diary_url(@diary), headers: { 'Authorization' => @user.auth_token }, as: :json
    end

    assert_response 204
  end
end
