class CreateTest < ActiveSupport::TestCase
  test 'should create Entry' do
    diary = Diary::Create.({diary: {name: 'Test Diary'}})
    result = Entry::Create.({entry: {title: 'Test Entry', body: 'Test Entry Body'}, diary_id: 4})

    assert result['model'].valid?
  end
end