require 'rails_helper'

RSpec.describe('Private Fields') do
  before do
    driven_by(:rack_test)
    @user = FactoryBot.create(:user)
    @user2 = FactoryBot.create(:user, email: "test2@gmail.com", uid: "00001", full_name: "Test2 User2", user_first_name: "Test2", user_last_name: "User2", user_contact_email: "test2@gmail.com", user_ph_num: "123-456-7890", user_class_year: "2024", user_job_field: "testjob2", user_location: "city2", user_status: "alumni", user_major: "Computer Engineering")
  end

  # private email tests
  context 'when is_contact_email_private is False' do
    it 'displays the user contact email' do
      # Sign in as user2
      sign_in @user2

      # Access the user's profile and check if the contact email is displayed
      visit user_path(@user)
      expect(page).to have_content(@user.user_contact_email)
    end
  end

  context 'when is_contact_email_private is True' do
    it 'does NOT display the user contact email' do
      # Sign in as user, and update is_contact_email_private to true
      sign_in @user
      @user.update(is_contact_email_private: true)

      # Sign out and sign in as user2
      sign_out @user
      sign_in @user2

      # Access the user's profile and check if the contact email is NOT displayed
      visit user_path(@user)
      expect(page).not_to have_content(@user.user_contact_email)
    end
  end

  # private phone number tets
  context 'when is_ph_num_private is False' do
    it 'displays the user phone number' do
      # Sign in as user2
      sign_in @user2

      # Access the user's profile and check if the contact email is displayed
      visit user_path(@user)
      expect(page).to have_content(@user.user_ph_num)
    end
  end

  context 'when is_ph_num_private is True' do
    it 'does NOT display the user phone number' do
      # Sign in as user, and update is_ph_num_private to true
      sign_in @user
      @user.update(is_ph_num_private: true)

      # Sign out and sign in as user2
      sign_out @user
      sign_in @user2

      # Access the user's profile and check if the phone number is NOT displayed
      visit user_path(@user)
      expect(page).not_to have_content(@user.user_ph_num)
    end
  end

  # private class year tests
  context 'when is_class_year_private is False' do
    it 'displays the user class year' do
      # Sign in as user2
      sign_in @user2

      # Access the user's profile and check if the contact email is displayed
      visit user_path(@user)
      expect(page).to have_content(@user.user_class_year)
    end
  end

  context 'when is_class_year_private is True' do
    it 'does NOT display the user class year' do
      # Sign in as user, and update is_class_year_private to true
      sign_in @user
      @user.update(is_class_year_private: true)

      # Sign out and sign in as user2
      sign_out @user
      sign_in @user2

      # Access the user's profile and check if the class year is NOT displayed
      visit user_path(@user)
      expect(page).not_to have_content(@user.user_class_year)
    end
  end

  # private job field tests
  context 'when is_job_field_private is False' do
    it 'displays the user job field' do
      # Sign in as user2
      sign_in @user2

      # Access the user's profile and check if the job field is displayed
      visit user_path(@user)
      expect(page).to have_content(@user.user_job_field)
    end
  end

  context 'when is_job_field_private is True' do
    it 'does NOT display the user job field' do
      # Sign in as user, and update is_job_field_private to true
      sign_in @user
      @user.update(is_job_field_private: true)

      # Sign out and sign in as user2
      sign_out @user
      sign_in @user2

      # Access the user's profile and check if the job field is NOT displayed
      visit user_path(@user)
      expect(page).not_to have_content(@user.user_job_field)
    end
  end

  # private location tests
  context 'when is_location_private is False' do
    it 'displays the user location' do
      # Sign in as user2
      sign_in @user2

      # Access the user's profile and check if the location is displayed
      visit user_path(@user)
      expect(page).to have_content(@user.user_location)
    end
  end

  context 'when is_location_private is True' do
    it 'does NOT display the user location' do
      # Sign in as user, and update is_location_private to true
      sign_in @user
      @user.update(is_location_private: true)

      # Sign out and sign in as user2
      sign_out @user
      sign_in @user2

      # Access the user's profile and check if the location is NOT displayed
      visit user_path(@user)
      expect(page).not_to have_content(@user.user_location)
    end
  end

  # private major tests
  context 'when is_major_private is False' do
    it 'displays the user major' do
      # Sign in as user2
      sign_in @user2

      # Access the user's profile and check if the major is displayed
      visit user_path(@user)
      expect(page).to have_content(@user.user_major)
    end
  end

  context 'when is_major_private is True' do
    it 'does NOT display the user major' do
      # Sign in as user, and update is_major_private to true
      sign_in @user
      @user.update(is_major_private: true)

      # Sign out and sign in as user2
      sign_out @user
      sign_in @user2

      # Access the user's profile and check if the major is NOT displayed
      visit user_path(@user)
      expect(page).not_to have_content(@user.user_major)
    end
  end
end