require 'rails_helper'

RSpec.describe('Private Fields') do
  before do
    driven_by(:rack_test)
  end

  context 'when is_contact_email_private is False' do
    it 'displays the user contact email' do
      # create users
      user = FactoryBot.create(:user)
      user2 = FactoryBot.create(:user)

      # Sign in as user2
      sign_in user2

      # Access the user's profile and check if the contact email is displayed
      visit user_path(user)
      expect(page).to have_content(user.contact_email)
    end
  end

  #context 'when is_contact_email_private is True' do
    #it 'does NOT display the user contact email' do
      #user = FactoryBot.create(:user)
      #user2 = FactoryBot.create(:user)

      ## Sign in as user, and update is_contact_email_private to true
      #sign_in user
      #user.update(is_contact_email_private: true)

      ## Sign out and sign in as user2
      #sign_out user
      #sign_in user2

      # Access the user's profile and check if the contact email is NOT displayed
      #visit user_path(user)
      #expect(page).not_to have_content(user.contact_email)
    #end
  #end
end