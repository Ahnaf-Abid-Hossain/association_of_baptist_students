class Alumni < ApplicationRecord
  belongs_to :user
  has_many :meeting_note
end
