class User::Update < Trailblazer::Operation
  extend Contract::DSL

  # step     :debug
  step     Model( User, :find )
  step     Contract::Build(constant: User::Contract::UserForm)
  step     Contract::Validate( key: :user )
  failure  :log_error!
  step     Contract::Persist(  )

  success :generate_json
  failure :log_error!

  def debug(options)
    binding.pry
  end

  def log_error!(options)
    options['response.status'] = 422
    options['presenter.default'] = {errors: options['contract.default'].errors.messages }
  end

  def generate_json(options)
    options['response.status'] = 200
    options['presenter.default'] = UserDecorator.new(options['model']).to_json
  end
end