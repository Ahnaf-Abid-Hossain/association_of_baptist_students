FactoryBot.define do
    factory :user do
        email { 'test@gmail.com' }
        uid { '00000' }
        full_name { 'Test User' }
        avatar_url { '/' }
        is_admin { false }
    end
end