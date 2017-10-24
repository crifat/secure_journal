require 'roar/decorator'
require 'roar/json'

class DiaryDecorator < Roar::Decorator
  include Roar::JSON

  property :id
  property :name
  property :updated_at
end