require 'rails_helper'

RSpec.describe('User Bar') do
  before do
    driven_by(:rack_test)
  end

  it 'displays the name of the logged in user' do
    # Sign in
    user = FactoryBot.create(:user)
    sign_in user

    # Go to the directory page
    visit "/users"

    # Expect User Bar to contain user's full name
    expect(page).to(have_css('h3', text: "Logged in as: #{user.full_name}"))
  end

  it 'logs out the user when Log Out is pressed' do
    # Sign in
    user = FactoryBot.create(:user)
    sign_in user

    # Go to the directory page
    visit "/users"

    # Press Log Out
    click_link 'Log out'

    # Go back to the directory page
    get "/users"

    # Expect to be logged out
    expect(response).to(redirect_to('/users/sign_in'))
  end
end
