class CreateTest < ActiveSupport::TestCase
  test 'should create Entry' do
    user = User::Create.(user: {email: "user-#{SecureRandom.hex(4)}@gmail.com", password: '121345678', password_confirmation: '12345678'})['model']
    diary = Diary::Create.({diary: {name: 'Test Diary', user_id: user.id}})['model']
    result = Entry::Create.({entry: {title: 'Test Entry', body: 'Test Entry Body'}, diary_id: diary.id})

    assert result['model'].valid?
  end
end