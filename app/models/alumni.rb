class Alumni < ApplicationRecord
  belongs_to :user
  has_many :prayer_requests, dependent: nil
  has_many :meeting_note, dependent: nil
end
