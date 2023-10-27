FactoryBot.define do
  factory :link do
    label { 'MyString' }
    url { 'MyString' }
    order { 1 }
    user
  end
end
