class Alumni < ApplicationRecord
  belongs_to :user
  has_many :prayer_requests
end
