require 'rails_helper'

RSpec.describe('New User Redirect') do
  before do
    driven_by(:rack_test)
  end

  it 'redirects a new user to profile creation from index' do
    # Create user WITHOUT alumni
    user = FactoryBot.create(:user_no_profile)

    # Sign in
    sign_in user

    # Go to the root
    get '/alumnis'

    # Expect to be redirected to profile creation
    expect(response).to(redirect_to('/alumnis/new'))
  end

  it 'redirects an existing user to the directory page from index' do
    # Create user with alumni
    user = FactoryBot.create(:user)

    # Sign in
    sign_in user

    # Go to the root
    get '/alumnis'

    # Expect to be redirected to directory page
    expect(response).to(have_http_status(:ok))
  end
end
