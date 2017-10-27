require 'test_helper'

class EntriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    #TODO Need to move to the test helper
    @user = User::Create.(user: {email: "user-#{SecureRandom.hex(4)}@gmail.com", password: '121345678', password_confirmation: '12345678'})['model']
    @diary = Diary::Create.({diary: {name: 'Test Diary'}})['model']
    @entry = Entry::Create.({entry: {title: 'Test Entry', body: 'Test Entry Body'}, diary_id: @diary.id})['model']
  end

  test "should get index" do
    get diary_entries_url(diary_id: @diary.id, id: @entry.id), headers: { 'Authorization' => @user.auth_token }, as: :json
    assert_response :success
  end

  test "should create entry" do
    assert_difference('Entry.count') do
      post diary_entries_url(diary_id: @diary.id, id: @entry.id), params: { entry: { body: @entry.body, diary_id: @entry.diary_id, title: @entry.title }, diary_id: @diary.id }, headers: { 'Authorization' => @user.auth_token }, as: :json
    end

    assert_response 201
  end

  test "should show entry" do
    get diary_entry_url(diary_id: @diary.id, id: @entry.id), headers: { 'Authorization' => @user.auth_token }, as: :json
    assert_response :success
  end

  test "should update entry" do
    patch diary_entry_url(diary_id: @diary.id, id: @entry.id), params: { entry: { body: @entry.body, diary_id: @entry.diary_id, title: @entry.title } }, headers: { 'Authorization' => @user.auth_token }, as: :json
    assert_response 200
  end

  test "should destroy entry" do
    assert_difference('Entry.count', -1) do
      delete diary_entry_url(diary_id: @diary.id, id: @entry.id), headers: { 'Authorization' => @user.auth_token }, as: :json
    end

    assert_response 204
  end
end
