require 'roar/decorator'
require 'roar/json'

class UserDecorator < Roar::Decorator
  include Roar::JSON

  property :id
  property :email
  property :auth_token
end