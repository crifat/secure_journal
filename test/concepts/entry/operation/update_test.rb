class UpdateTest < ActiveSupport::TestCase
  test 'should Update Entry' do
    user = User::Create.(user: {email: "user-#{SecureRandom.hex(4)}@gmail.com", password: '121345678', password_confirmation: '12345678'})['model']
    diary = Diary::Create.({diary: {name: 'Test Diary', user_id: user.id}})['model']
    entry = Entry::Create.({entry: {title: 'Test Entry', body: 'Test Entry Body'}, diary_id: diary.id})['model']
    result = Entry::Update.({id: entry.id, entry: {title: 'Updated Entry'}})

    assert result['model'].valid?
    assert_equal 'Updated Entry', result['model'].title
  end
end