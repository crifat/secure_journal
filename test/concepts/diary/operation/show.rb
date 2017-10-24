class ShowTest < ActiveSupport::TestCase
  test 'should display diary' do
    diary = Diary::Create.({name: 'Test Diary'})

    result = Diary::Show.(id: diary['model'].id)

    assert result['model'].id.present?
    assert_equal 'Test Diary', result['model'].name
  end
end