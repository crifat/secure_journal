class UpdateTest < ActiveSupport::TestCase
  test 'should Update Entry' do
    diary = Diary::Create.({diary: {name: 'Test Diary'}})
    entry = Entry::Create.({entry: {title: 'Test Entry', body: 'Test Entry Body'}, diary_id: diary['model'].id})
    result = Entry::Update.({id: entry['model'].id, entry: {title: 'Updated Entry'}})

    assert result['model'].valid?
    assert_equal 'Updated Entry', result['model'].title
  end
end