class Session::Create < Trailblazer::Operation
  # step :debug
  step :authenticate!
  step :generate_auth_token!
  step :generate_json!

  success :generate_json!
  failure :log_errors!

  def debug(options)
    binding.pry
  end

  def authenticate!(options)
    user_email = options['params'][:session][:email]
    user = User.find_by(email: user_email)
    if user.valid_password? options['params'][:session][:password]
      options['model'] = user
      options['response.status'] = 201
      options['presenter.default'] = UserDecorator.new(options['model']).to_json
    end
  end

  def generate_auth_token!(options)
    options['model'].auth_token = loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless User.exists?(auth_token: random_token)
    end
    options['model'].save
  end

  def generate_json!(options)
    options['response.status'] = 201
    options['presenter.default'] = {id: options['model'][:id], auth_token: options['model'][:auth_token], decryptor_key: options['model'][:encryption_key].decrypt(options['params'][:session][:password])}
  end

  def log_errors!(options)
    options['response.status'] = 422
    options['presenter.default'] = {errors: "Invalid Email or Password" }
  end
end