require 'roar/decorator'
require 'roar/json'

class EntryDecorator < Roar::Decorator
  include Roar::JSON

  property :id
  property :title
  property :body
  property :diary_id
  property :updated_at
end