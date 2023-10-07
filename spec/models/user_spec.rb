require 'rails_helper'

RSpec.describe User, type: :model do
  it 'should allow gmail accounts to log in' do
    user = User.from_google(email: 'test@gmail.com', uid: '00000', full_name: 'Test User', avatar_url: '/')
    expect(user).to_not eq(nil)
  end

  it 'should disallow tamu accounts from logging in' do
    user = User.from_google(email: 'test@tamu.edu', uid: '00000', full_name: 'Test User', avatar_url: '/')
    expect(user).to eq(nil)
  end

  it 'should correctly report if it has a profile' do
    # Make a user
    user = User.from_google(email: 'test@gmail.com', uid: '00000', full_name: 'Test User', avatar_url: '/')

    # Make a profile for the user
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

    # User should report has_profile
    expect(user.user).to be user_profile
  end

  it 'should correctly report if it does NOT have a profile' do
    # Make a user
    user = User.from_google(email: 'test@gmail.com', uid: '00000', full_name: 'Test User', avatar_url: '/')

    # Do not make a profile for the user

    # User should report has_profile
    expect(user.user).to be_nil
  end
end
