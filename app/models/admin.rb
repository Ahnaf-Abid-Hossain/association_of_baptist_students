class Admin < ApplicationRecord
  devise :database_authenticatable, :omniauthable, omniauth_providers: [:google_oauth2]
end
