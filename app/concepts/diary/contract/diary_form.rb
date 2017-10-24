module Diary::Contract
  # Contract for user related form
  # it validates form's properties
  class DiaryForm < Reform::Form

    property :name

    validates :name, presence: true
  end
end