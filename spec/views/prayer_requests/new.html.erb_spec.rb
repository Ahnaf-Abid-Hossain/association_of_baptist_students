require 'rails_helper'

RSpec.describe('prayer_requests/new') do
  before do
    @user1 = FactoryBot.create(:user, email: 'user1@gmail.com')
    @admin = FactoryBot.create(:admin_user, email: 'admin@gmail.com')
  end

  after do
    @user1.destroy!
    @admin.destroy!
  end

  context 'admin creating their own prayer request' do
    it 'renders the request field in the create prayer_request form' do
      sign_in @admin
      prayer_request = PrayerRequest.new
      assign(:prayer_request, prayer_request)

      render

      assert_select 'form[action=?][method=?]', prayer_requests_path, 'post' do
        assert_select 'input[name=?]', 'prayer_request[request]'
      end
    end
  end

  context 'admin creating their own prayer request' do
    it 'does not render the status field in the create prayer_request form' do
      sign_in @admin
      prayer_request = PrayerRequest.new
      assign(:prayer_request, prayer_request)

      render

      assert_select 'form[action=?][method=?]', prayer_requests_path, 'post' do
        assert_select 'input[name=?]', 'prayer_request[status]', count: 0
      end
    end
  end

  context 'admin creating their own prayer request' do
    it 'renders the is_anonymous checkbox defaulted to anonymous in the create prayer_request form' do
      sign_in @admin
      prayer_request = PrayerRequest.new
      assign(:prayer_request, prayer_request)

      render

      assert_select 'form[action=?][method=?]', prayer_requests_path, 'post' do
        assert_select 'input[type=?][checked=?][name=?]', 'checkbox', 'checked', 'prayer_request[is_anonymous]'
      end
    end
  end

  context 'user creating their own prayer request' do
    it 'renders the request field in the create prayer_request form' do
      sign_in @user1
      prayer_request = PrayerRequest.new
      assign(:prayer_request, prayer_request)

      render

      assert_select 'form[action=?][method=?]', prayer_requests_path, 'post' do
        assert_select 'input[name=?]', 'prayer_request[request]'
      end
    end
  end

  context 'user creating their own prayer request' do
    it 'does not render the status field in the create prayer_request form' do
      sign_in @user1
      prayer_request = PrayerRequest.new
      assign(:prayer_request, prayer_request)

      render

      assert_select 'form[action=?][method=?]', prayer_requests_path, 'post' do
        assert_select 'input[name=?]', 'prayer_request[status]', count: 0
      end
    end
  end

  context 'user creating their own prayer request' do
    it 'renders the is_anonymous checkbox defaulted to anonymous in the create prayer_request form' do
      sign_in @user1
      prayer_request = PrayerRequest.new
      assign(:prayer_request, prayer_request)

      render

      assert_select 'form[action=?][method=?]', prayer_requests_path, 'post' do
        assert_select 'input[type=?][checked=?][name=?]', 'checkbox', 'checked', 'prayer_request[is_anonymous]'
      end
    end
  end
end
