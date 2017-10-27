class UpdateTest < ActiveSupport::TestCase
  test 'should Update Diary' do
    user = User::Create.(user: {email: "user-#{SecureRandom.hex(4)}@gmail.com", password: '121345678', password_confirmation: '12345678'})['model']
    diary = Diary::Create.({diary: {name: 'Test Diary', user_id: user.id}})['model']
    result = Diary::Update.({id: diary.id, diary: {name: 'Updated Diary'}})

    assert result['model'].valid?
    assert_equal 'Updated Diary', result['model'].name
  end
end