class User::Show < Trailblazer::Operation
  step     Model( User, :find )
  success :generate_json
  failure :log_errors!

  def log_errors!(options)
    options['response.status'] = 422
    options['presenter.default'] = {errors: "Something is wrong" }
  end

  def generate_json(options)
    options['response.status'] = 200
    options['presenter.default'] = UserDecorator.new(options['model']).as_json
  end
end