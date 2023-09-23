require 'rails_helper'

RSpec.describe "User Bar", type: :system do
  before do
    driven_by(:rack_test)
  end

  it 'should display the name of the logged in user' do
    # Sign in
    user = FactoryBot.create(:user)
    sign_in user

    # Go to the log in page
    visit "/alumnis"

    # Expect User Bar
    expect(page).to have_css('h3', text: 'Logged in as: ' + user.full_name)
  end

  it 'should log out the user when Log Out is pressed' do
    # Sign in
    user = FactoryBot.create(:user)
    sign_in user

    # Go to the log in page
    visit "/alumnis"

    # Press Log Out
    click_link 'Log out'

    # Expect to be logged out
    get "/alumnis"
    expect(response).to redirect_to("/users/sign_in")
  end
end