FactoryBot.define do
  factory :user do
    email { 'test@gmail.com' }
    uid { '00000' }
    full_name { 'Test User' }
    avatar_url { '/' }
    is_admin { false }
    user_first_name { 'Test'}
    user_last_name { 'User'}
    user_contact_email { 'test@gmail.com' }
    user_ph_num { '123-456-7890'}
    user_class_year { 24 }
    user_job_field { 'test' }
    user_location { 'city' }
    user_status { 'alumni' }
    user_major { 'Computer Science' }

    factory :admin_user do
      email { 'admin@gmail.com' }
      uid { '00000' }
      full_name { 'Admin User' }
      avatar_url { '/' }
      is_admin { true }
      user_first_name { 'Test'}
      user_last_name { 'User'}
      user_contact_email { 'test@gmail.com' }
      user_ph_num { '123-456-7890'}
      user_class_year { 24 }
      user_job_field { 'test' }
      user_location { 'city' }
      user_status { 'alumni' }
      user_major { 'Computer Science' }
    end
  end
end
