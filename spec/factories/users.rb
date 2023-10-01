FactoryBot.define do
  factory :user do
    email { 'test@gmail.com' }
    uid { '00000' }
    full_name { 'Test User' }
    avatar_url { '/' }
    is_admin { false }

    # If alumni is not present, create a new transient Alumni
    transient do
      alumni { FactoryBot.build(:alumni) }
    end

    after(:build) do |prayer_request, evaluator|
      prayer_request.alumni = evaluator.alumni
    end

    factory :user_no_profile do
      email { 'test@gmail.com' }
      uid { '00000' }
      full_name { 'Test User' }
      avatar_url { '/' }
      is_admin { false }
      alumni { nil }
    end
  end
end
