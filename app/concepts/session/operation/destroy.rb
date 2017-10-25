class Session::Create < Trailblazer::Operation
  extend Contract::DSL
  step     :find_user!
  step     :generate_auth_token!

  def find_user!(options)
    options['model'] = options['current_user']
  end

  def generate_auth_token!(options)
    options['model'].auth_token = loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless User.exists?(auth_token: random_token)
    end
    options['model'].save
  end
end