class User::Create < Trailblazer::Operation
  extend Contract::DSL

  # step :debug!
  step     Model( User, :new )
  step     Contract::Build(constant: User::Contract::UserForm)
  step     Contract::Validate( key: :user )
  step     :generate_auth_token!
  step     :generate_encryption_key!
  failure  :log_error!
  step     Contract::Persist(  )

  success :generate_json
  failure :log_error!

  def debug!(options)
    binding.pry
  end

  def generate_auth_token!(options)
    options['model'].auth_token = loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless User.exists?(auth_token: random_token)
    end
  end

  def generate_encryption_key!(options)
    actual_key = SecureRandom.hex(16)
    password = options['params'][:user][:password]
    encrypted_key = actual_key.encrypt(password)
    options['contract.default'].model.encryption_key = encrypted_key
  end

  def log_error!(options)
    options['response.status'] = 422
    options['presenter.default'] = {errors: options['contract.default'].errors.messages }
  end

  def generate_json(options)
    options['response.status'] = 201
    options['presenter.default'] = UserDecorator.new(options['model']).to_json
  end
end