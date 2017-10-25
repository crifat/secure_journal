require "reform/form/validation/unique_validator"

module User::Contract
  # Contract for user related form
  # it validates form's properties
  class UserForm < Reform::Form
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

    property :email
    property :password
    property :password_confirmation

    validates :email, presence: true
    validates :email, unique: true, format: VALID_EMAIL_REGEX
  end
end