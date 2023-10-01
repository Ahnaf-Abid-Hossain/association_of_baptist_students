FactoryBot.define do
  factory :meeting_note do
    title { 'MyString' }
    content { 'MyText' }
    date { '2023-09-25' }

    # If alumni is not present, create a new transient Alumni
    transient do
      alumni { FactoryBot.create(:alumni) }
    end

    after(:build) do |prayer_request, evaluator|
      prayer_request.alumni = evaluator.alumni
    end
  end
end
