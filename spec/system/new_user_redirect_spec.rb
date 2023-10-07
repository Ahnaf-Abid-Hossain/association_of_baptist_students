require 'rails_helper'

RSpec.describe "New User Redirect", type: :system do
  before do
    driven_by(:rack_test)
  end

  it 'should redirect a new user to profile creation from index' do
    # Sign in
    user = FactoryBot.create(:user)
    sign_in user

    # Go to the root
    get "/users"

    # Expect to be redirected to profile creation
    expect(response).to redirect_to("/users/new") 
  end

  it 'should redirect an existing user to the directory page from index' do
    user = FactoryBot.create(:user)

    # Give user an user profile
    user_profile = user.new(
      user_first_name: "Test",
      user_last_name: "User",
      user_email: "test@gmail.com",
      user_ph_num: "(555) 555-5555",
      user_class_year: 2024,
      user_job_field: "Software Engineering",
      user_location: "Houston, TX",
      user_status: "Current Student",
      user_major: "Computer Science")

    # Assign profile to the user
    user_profile.user = user

    # Save profile
    user_profile.save

    # Sign in
    sign_in user

    # Go to the root
    get "/users"

    # Expect to be redirected to directory page
    expect(response.status).to be 200
  end
end