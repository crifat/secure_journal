class CreateTest < ActiveSupport::TestCase
  test 'should create Diary' do
    @result = Diary::Create.(name: 'Test Diary')

    assert @result['model'].valid?
  end
end