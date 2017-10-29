# == Schema Information
#
# Table name: diaries
#
#  id         :integer          not null, primary key
#  name       :string
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Diary < ApplicationRecord
  belongs_to :user
  has_many :entries
end
