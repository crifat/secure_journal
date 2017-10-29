class ShowTest < ActiveSupport::TestCase
  test 'should display Entry' do
    user = User::Create.(user: {email: "user-#{SecureRandom.hex(4)}@gmail.com", password: '121345678', password_confirmation: '12345678'})['model']
    diary = Diary::Create.({diary: {name: 'Test Diary', user_id: user.id}})['model']
    entry = Entry::Create.({entry: {title: 'Test Entry', body: 'Test Entry Body'}, diary_id: diary.id})['model']
    result = Entry::Show.({id: entry.id, diary_id: diary.id}, 'current_user' => user)

    assert result['model'].id.present?
    assert_equal 'Test Entry', result['model'].title
  end
end