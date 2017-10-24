class UpdateTest < ActiveSupport::TestCase
  test 'should Update Diary' do
    diary = Diary::Create.(diary: {name: 'Test Diary'})
    result = Diary::Update.({id: diary['model'].id, diary: {name: 'Updated Diary'}})

    assert result['model'].valid?
    assert_equal 'Updated Diary', result['model'].name
  end
end