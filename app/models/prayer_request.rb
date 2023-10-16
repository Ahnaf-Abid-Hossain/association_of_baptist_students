class PrayerRequest < ApplicationRecord
  # Validations
  validates :request, presence: true
  validates :status, presence: true
  validates :user_id, presence: true

  # Associations
  belongs_to :user
end
