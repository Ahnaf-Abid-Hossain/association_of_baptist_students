require 'rails_helper'

RSpec.describe('Advanced Search') do
  before do
    driven_by(:rack_test)
  end

  # First Name search test
  it 'displays the name of the logged in user, when given first name' do
    # Sign in
    user = FactoryBot.create(:user)
    sign_in user

    # Go to the search page
    visit '/search'

    # fill in data
    fill_in "search_name", with: "Test"
    click_button "Search"

    # Expect User Bar to contain user's full name
    expect(page).to have_content("Test User")
  end

  # Last Name search test
  it 'displays the name of the logged in user, when given last name' do
    # Sign in
    user = FactoryBot.create(:user)
    sign_in user

    # Go to the search page
    visit '/search'

    # fill in data
    fill_in "search_name", with: "User"
    click_button "Search"

    # Expect User Bar to contain user's full name
    expect(page).to have_content("Test User")
  end

  # Full Name search test
  it 'displays the name of the logged in user, when given full name' do
    # Sign in
    user = FactoryBot.create(:user)
    sign_in user

    # Go to the search page
    visit '/search'

    # fill in data
    fill_in "search_name", with: "Test User"
    click_button "Search"

    # Expect User Bar to contain user's full name
    expect(page).to have_content("Test User")
  end
end