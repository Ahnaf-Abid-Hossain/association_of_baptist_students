FactoryBot.define do
  factory :user do
    email { 'test@gmail.com' }
    uid { '00000' }
    full_name { 'Test User' }
    avatar_url { '/' }
    is_admin { false }
  end
  factory :admin_user do
    email { 'admin@gmail.com' }
    uid { '00000' }
    full_name { 'Admin User' }
    avatar_url { '/' }
    is_admin { true }
  end
end
