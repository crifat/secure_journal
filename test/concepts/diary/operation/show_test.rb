class ShowTest < ActiveSupport::TestCase
  test 'should display diary' do
    user = User::Create.(user: {email: "user-#{SecureRandom.hex(4)}@gmail.com", password: '121345678', password_confirmation: '12345678'})['model']
    diary = Diary::Create.({diary: {name: 'Test Diary', user_id: user.id}})

    result = Diary::Show.(id: diary['model'].id)

    assert result['model'].id.present?
    assert_equal 'Test Diary', result['model'].name
  end
end