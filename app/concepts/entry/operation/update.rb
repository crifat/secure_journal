class Entry::Update < Trailblazer::Operation
  extend Contract::DSL

  # step     :debug
  step     Model( Entry, :find )
  step     Contract::Build(constant: Entry::Contract::EntryForm)
  step     Contract::Validate( key: :entry )
  # step     :encrypt_entry!
  failure  :log_error!
  step     Contract::Persist(  )

  success :generate_json
  failure :log_error!

  def debug(options)
    binding.pry
  end

  def encrypt_entry!(options)
    #FIXME: This won't work if the password is update.
    #TODO: Decrypt and Re-encrypt every entry before updating password.
  end

  def log_error!(options)
    options['response.status'] = 422
    options['presenter.default'] = {errors: options['contract.default'].errors.messages }
  end

  def generate_json(options)
    options['response.status'] = 200
    options['presenter.default'] = EntryDecorator.new(options['model']).to_json
  end
end