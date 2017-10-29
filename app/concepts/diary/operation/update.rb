class Diary::Update < Trailblazer::Operation
  extend Contract::DSL

  # step     :debug
  step     Model( Diary, :find )
  step     Contract::Build(constant: Diary::Contract::DiaryForm)
  step     Contract::Validate( key: :diary )
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
    options['presenter.default'] = DiaryDecorator.new(options['model']).to_json
  end
end