class CreateTest < ActiveSupport::TestCase
  test 'should generate auth token and decryptor key' do
    user = User::Create.(user: {email: "user-#{SecureRandom.hex(4)}@gmail.com", password: '12345678', password_confirmation: '12345678'})['model']
    @result = Session::Create.(session: {email: user.email, password: '12345678'})

    assert @result['presenter.default'][:auth_token].present?
    assert @result['presenter.default'][:decryptor_key].present?
  end
end