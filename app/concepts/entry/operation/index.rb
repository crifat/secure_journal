class Entry::Index < Trailblazer::Operation
  step :find_diary!

  success :generate_json!
  failure :log_errors!

  def find_diary!(options)
    options['diary'] = options['current_user'].diaries.find_by(id: options['params'][:diary_id])
  end

  def generate_json!(options)
    data = {
        diary: DiaryDecorator.new(options['diary']),
        entries: []
    }
    options['diary'].entries.each do |entry|
      data[:entries] << EntryDecorator.new(entry).as_json
    end
    options['presenter.default'] = data
  end

  def log_errors!(options)
    options['response.status'] = 404
    options['presenter.default'] = {errors: 'Not found' }
  end
end