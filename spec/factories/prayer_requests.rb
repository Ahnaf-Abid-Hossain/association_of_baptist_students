FactoryBot.define do
  factory :prayer_request do
    request { 'Please pray for me.' }
    status { 'pending' }

    # If alumni is not present, create a new transient Alumni
    transient do
      alumni { FactoryBot.build(:alumni) }
    end

    after(:build) do |prayer_request, evaluator|
      prayer_request.alumni = evaluator.alumni
    end

    # If you want to generate a valid prayer_request with specific attributes
    factory :valid_prayer_request do
      # Custom attributes
      request { 'This is a specific prayer request.' }
      status { 'not_read' }
      # Add any other attributes you want to customize
    end

    # If you want to generate an invalid prayer_request (e.g., missing request)
    factory :invalid_prayer_request do
      # Invalid because request is required
      request { nil }
      status { 'pending' }
    end
  end
end
