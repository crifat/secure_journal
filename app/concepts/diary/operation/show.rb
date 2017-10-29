class Diary::Show < Trailblazer::Operation
  step     Model( Diary, :find_by )
  success :generate_json
  failure :log_errors!

  def log_errors!(options)
    options['response.status'] = 404
    options['presenter.default'] = {errors: "Not found" }
  end

  def generate_json(options)
    options['response.status'] = 200
    options['presenter.default'] = DiaryDecorator.new(options['model']).as_json
  end
end