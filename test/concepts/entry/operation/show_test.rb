class ShowTest < ActiveSupport::TestCase
  test 'should display Entry' do
    diary = Diary::Create.({diary: {name: 'Test Diary'}})
    entry = Entry::Create.({entry: {title: 'Test Entry', body: 'Test Entry Body'}, diary_id: diary['model'].id})
    result = Entry::Show.(id: entry['model'].id)

    assert result['model'].id.present?
    assert_equal 'Test Entry', result['model'].title
  end
end