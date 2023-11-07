FactoryBot.define do
  factory :prayer_request do
    request { 'Please pray for me.' }
    status { 'Not read' }
    user
    is_anonymous { true }
    is_public { true }

    factory :invalid_prayer_request_no_request do
      # Invalid because request is required
      request { nil }
    end

    factory :invalid_prayer_request_no_status do
      # Invalid because status is required
      status { nil }
    end
  end
end
