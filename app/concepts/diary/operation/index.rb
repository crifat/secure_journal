class Diary::Index < Trailblazer::Operation
  step :find_diaries!

  success :generate_json!
  failure :log_errors!

  def find_diaries!(options)
    options['diaries'] = options['current_user'].diaries
  end

  def generate_json!(options)
    data = []
    options['diaries'].each do |diary|
      data << DiaryDecorator.new(diary).as_json
    end
    options['presenter.default'] = data
  end

  def log_errors!(options)
    options['response.status'] = 404
    options['presenter.default'] = {errors: options['contract.default'].errors.messages }
  end
end