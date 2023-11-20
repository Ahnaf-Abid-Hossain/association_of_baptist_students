class User < ApplicationRecord
  has_one :user, dependent: nil
  has_many :prayer_requests, dependent: nil
  has_many :meeting_note, dependent: nil
  has_many :links, dependent: nil

  validates :user_first_name, presence: true, if: :editing_profile?
  validates :user_last_name, presence: true, if: :editing_profile?

  devise :omniauthable, omniauth_providers: [:google_oauth2]

  def editing_profile?
    # check if record is not a new record
    !new_record?
  end

  def self.from_google(email:, full_name:, uid:, avatar_url:)
    return nil unless /@gmail.com\z/.match?(email)

    create_with(uid: uid, full_name: full_name, avatar_url: avatar_url).find_or_create_by!(email: email)
  end
end
