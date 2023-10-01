FactoryBot.define do
  factory :alumni do
    alum_first_name { 'Test' }
    alum_last_name { 'User' }
    alum_email { 'test@gmail.com' }
    alum_ph_num { '(555) 555-5555' }
    alum_class_year { 2024 }
    alum_job_field { 'Software Engineering' }
    alum_location { 'Houston, TX' }
    alum_status { 'Current Student' }
    alum_major { 'Computer Science' }

    # If user is not present, create a new transient User
    transient do
      user { FactoryBot.build(:user) }
    end

    after(:build) do |alumni, evaluator|
      alumni.user = evaluator.user
      alumni.user.email = alumni.alum_email
      alumni.user.save!
    end

  end
end
