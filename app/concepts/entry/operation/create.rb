class Entry::Create < Trailblazer::Operation

  step     Model( Entry, :new )
  step     :assign_diary
  step     Contract::Build(constant: Entry::Contract::EntryForm)
  step     Contract::Validate( key: :entry )
  failure  :log_error!
  # step     :encrypt_entry!
  step     Contract::Persist(  )

  success :generate_json
  failure :log_error!

  def assign_diary(options)
    options['model'].diary_id = options['params'][:diary_id]
  end

  def encrypt_entry!(options)

  end

  def log_error!(options)
    options['response.status'] = 422
    options['presenter.default'] = {errors: options['contract.default'].errors.messages }
  end

  def generate_json(options)
    options['response.status'] = 201
    options['presenter.default'] = EntryDecorator.new(options['model']).to_json
  end
end