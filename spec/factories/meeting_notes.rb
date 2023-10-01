FactoryBot.define do
  factory :meeting_note do
    title { 'MyString' }
    content { 'MyText' }
    date { '2023-09-25' }
    alumni { nil }
  end
end
