require 'rails_helper'

RSpec.describe(User, type: :model) do
  it 'allows gmail accounts to log in' do
    user = described_class.from_google(email: 'test@gmail.com', uid: '00000', full_name: 'Test User', avatar_url: '/')
    expect(user).not_to(eq(nil))
  end

  it 'disallows tamu accounts from logging in' do
    user = described_class.from_google(email: 'test@tamu.edu', uid: '00000', full_name: 'Test User', avatar_url: '/')
    expect(user).to(eq(nil))
  end

  it 'correctlies report if it has a profile' do
    # Make a user
    user = described_class.from_google(email: 'test@gmail.com', uid: '00000', full_name: 'Test User', avatar_url: '/')

    # Make a profile for the user
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

    # User should report has_profile
    expect(user.alumni).to(be(alumni_profile))
  end

  it 'correctlies report if it does NOT have a profile' do
    # Make a user
    user = described_class.from_google(email: 'test@gmail.com', uid: '00000', full_name: 'Test User', avatar_url: '/')

    # Do not make a profile for the user

    # User should report has_profile
    expect(user.alumni).to(be_nil)
  end
end
