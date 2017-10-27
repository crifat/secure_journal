module Diary::Contract
  # Contract for user related form
  # it validates form's properties
  class DiaryForm < Reform::Form

    property :name
    property :user_id

    validates :name, presence: true
  end
end