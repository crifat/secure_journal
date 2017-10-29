module Entry::Contract
  # Contract for user related form
  # it validates form's properties
  class EntryForm < Reform::Form

    property :title
    property :body
    property :diary_id

    validates :body, :diary_id, presence: true
  end
end