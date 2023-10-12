require 'rails_helper'

RSpec.describe('Advanced Search') do
  before do
    driven_by(:rack_test)
  end

  it 'displays the name of the logged in user' do
    # Sign in
    user = FactoryBot.create(:user)
    sign_in user

    # Go to the search page
    visit '/users/search'

    # fill in data
    fill_in "First Name", with: "John"
    click_button "Search"

    # Expect User Bar to contain user's full name
    expect(page).to have_content("John Doe")
  end
end