FactoryBot.define do
  factory :meeting_note do
    title { 'MyString' }
    content { 'MyText' }
    date { '2023-09-25' }

    # If user is not present, create a new transient user
    transient do
      user { FactoryBot.build(:user) }
    end

    after(:build) do |prayer_request, evaluator|
      prayer_request.user = evaluator.user
    end
  end
end
