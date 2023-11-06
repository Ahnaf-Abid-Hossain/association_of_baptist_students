require 'rails_helper'

RSpec.describe('Edit and Delete User') do
  before do
    driven_by(:rack_test)
    @user = FactoryBot.create(:user)
    @user2 = FactoryBot.create(:user, email: 'test2@gmail.com', uid: '00001', full_name: 'Test2 User2', user_first_name: 'Test2', user_last_name: 'User2', user_contact_email: 'test2@gmail.com', user_ph_num: '123-456-7890', user_class_year: '2024', user_job_field: 'testjob2', user_location: 'city2', user_status: 'alumni', user_major: 'Computer Engineering', is_admin: 0)
  end

  # editing user tests
  context 'When a user tries to edit their own profile' do
    it 'they can edit it' do
      # sign in first user
      sign_in @user

      # attempt to visit first users edit page
      visit edit_user_path(@user)

      # expect to not be redirected
      expect(page).not_to have_http_status(302)

    end
  end

  context 'When a user tries to edit another users profile' do
    it 'they cannot edit it' do
      # sign in second user
      sign_in @user2

      # attempt to visit first users edit page
      visit edit_user_path(@user)

      # expect to be told that you can't
      expect(page).to have_text('You are not authorized to perform this action')
    end
  end

  # deleting user tests
  context 'When a user tries to delete their own profile' do
    it 'they can delete it' do
      # sign in second user
      sign_in @user

      # manually try to delete first user
      delete user_path(@user)

      # check if request did not work
      expect(User.where(id: @user.id)).to_not exist
    end
  end

  context 'When a user tries to delete another users profile' do
    it 'they cannot delete it' do
      # sign in second user
      sign_in @user2

      # manually try to delete first user
      delete user_path(@user)

      # check if request did not work
      expect(User.where(id: @user.id)).to exist
    end
  end

end