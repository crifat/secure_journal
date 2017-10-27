class Diary::Index < Trailblazer::Operation
  step :find_diary!
  step :get_all_entries!

  success :generate_json!
  failure :log_errors!

  def find_diary!(options)
    options['diary'] = options['current_user'].diaries.find(options['params'][:diary_id])
  end

  def get_all_entries!(options)

  end

  def generate_json!(options)

  end

  def log_errors!(options)
    options['response.status'] = 404
    options['presenter.default'] = {errors: options['contract.default'].errors.messages }
  end
end