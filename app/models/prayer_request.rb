class PrayerRequest < ApplicationRecord
  # Validations
  validates :request, presence: true
  validates :status, presence: true
  validates :is_anonymous, inclusion: { in: [true, false] }, allow_nil: true
  validates :is_public, inclusion: { in: [true, false] }, allow_nil: true

  # Associations
  belongs_to :user
end
