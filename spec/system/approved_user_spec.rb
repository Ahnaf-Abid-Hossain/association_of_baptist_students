require 'rails_helper'

RSpec.describe('Approved User') do
  before do
    driven_by(:rack_test)
    @user = FactoryBot.create(:user, approval_status: 0)
  end

  # Test for if user can only see account_created view before they're approved
  context 'when approval_status == 0' do
    it 'redirects the user to /account_created' do
      # Sign in as user
      sign_in @user

      # Try to access the root but expect to be redirected to '/account_created'
      visit root_path

      # Expect the response to be redirected to '/account_created'
      # Is this text hard coded here so if the text on the account_created view changes the test will no longer pass?
      # Yes
      # Did I do this because the other methods I tried were being dumb and not working? (Probably just me being dumb)
      # Also yes
      expect(page).to(have_text('Your account has been created!'))
      expect(page).to(have_text('You must wait for an administrator to approve your account before accessing the website'))
    end
  end
end
