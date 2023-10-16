class PrayerRequest < ApplicationRecord
  # Validations
  validates :request, presence: true
  validates :status, presence: true

  # Associations
  belongs_to :user
end
