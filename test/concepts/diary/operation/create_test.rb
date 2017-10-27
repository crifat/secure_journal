class CreateTest < ActiveSupport::TestCase
  test 'should create Diary' do
    user = User::Create.(user: {email: "user-#{SecureRandom.hex(4)}@gmail.com", password: '121345678', password_confirmation: '12345678'})['model']
    @result = Diary::Create.({diary: {name: 'Test Diary', user_id: user.id}})

    assert @result['model'].valid?
  end
end