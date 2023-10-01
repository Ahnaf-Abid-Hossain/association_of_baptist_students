require 'rails_helper'

RSpec.describe('New User Redirect') do
  before do
    driven_by(:rack_test)
  end

  it 'redirects a new user to profile creation from index' do
    # Sign in
    user = FactoryBot.create(:user)
    sign_in user

    # Go to the root
    get '/alumnis'

    # Expect to be redirected to profile creation
    expect(response).to(redirect_to('/alumnis/new'))
  end

  it 'redirects an existing user to the directory page from index' do
    user = FactoryBot.create(:user)

    # Give user an alumni profile
    alumni_profile = Alumni.new(
      alum_first_name: 'Test',
      alum_last_name: 'User',
      alum_email: 'test@gmail.com',
      alum_ph_num: '(555) 555-5555',
      alum_class_year: 2024,
      alum_job_field: 'Software Engineering',
      alum_location: 'Houston, TX',
      alum_status: 'Current Student',
      alum_major: 'Computer Science'
    )

    # Assign profile to the user
    alumni_profile.user = user

    # Save profile
    alumni_profile.save!

    # Sign in
    sign_in user

    # Go to the root
    get '/alumnis'

    # Expect to be redirected to directory page
    expect(response).to(have_http_status(:ok))
  end
end
