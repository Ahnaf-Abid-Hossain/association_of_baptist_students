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
    fill_in "First Name:", with: "Test"
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
    fill_in "Last Name:", with: "User"
    click_button "Search"

    # Expect User Bar to contain user's full name
    expect(page).to have_content("Test User")
  end

  # Class Year search test
  it 'displays the name of the logged in user, when given class year' do
    # Sign in
    user = FactoryBot.create(:user)
    sign_in user

    # Go to the search page
    visit '/search'

    # fill in data
    fill_in "Class Year:", with: 2024
    click_button "Search"

    # Expect User Bar to contain user's full name
    expect(page).to have_content("Test User")
  end

  # Major search test
  it 'displays the name of the logged in user, when given major' do
    # Sign in
    user = FactoryBot.create(:user)
    sign_in user

    # Go to the search page
    visit '/search'

    # fill in data
    fill_in "Major:", with: "Computer Science"
    click_button "Search"

    # Expect User Bar to contain user's full name
    expect(page).to have_content("Test User")
  end

  # Current city search test
  it 'displays the name of the logged in user, when given current city' do
    # Sign in
    user = FactoryBot.create(:user)
    sign_in user

    # Go to the search page
    visit '/search'

    # fill in data
    fill_in "First Name:", with: "city"
    click_button "Search"

    # Expect User Bar to contain user's full name
    expect(page).to have_content("Test User")
  end
end