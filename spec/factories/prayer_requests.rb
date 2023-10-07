FactoryBot.define do
  factory :prayer_request do
    request { "Please pray for me." }
    status { "pending" }

    # If user is not present, create a new transient user
    transient do
      user { FactoryBot.build(:user) }
    end

    after(:build) do |prayer_request, evaluator|
      prayer_request.user = evaluator.user
    end

    # If you want to generate a valid prayer_request with specific attributes
    factory :valid_prayer_request do
      # Custom attributes
      request { "This is a specific prayer request." }
      status { "not_read" }
      # Add any other attributes you want to customize
    end

    # If you want to generate an invalid prayer_request (e.g., missing request)
    factory :invalid_prayer_request do
      request { nil } # Invalid because request is required
      status { "pending" }
    end
  end
end
