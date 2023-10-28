require 'rails_helper'

RSpec.describe('prayer_requests/new') do
  let!(:user1) { FactoryBot.create(:user, email: 'user1@gmail.com') }
  let!(:admin) { FactoryBot.create(:admin_user, email: 'admin@gmail.com') }

  after do
    user1.destroy!
    admin.destroy!
  end

  context 'admin creating their own prayer request' do
    before { sign_in admin }

    it 'renders the request field in the create prayer_request form' do
      prayer_request = PrayerRequest.new
      assign(:prayer_request, prayer_request)

      render

      assert_select 'form[action=?][method=?]', prayer_requests_path, 'post' do
        assert_select 'input[name=?]', 'prayer_request[request]'
      end
    end

    it 'does not render the status field in the create prayer_request form' do
      prayer_request = PrayerRequest.new
      assign(:prayer_request, prayer_request)

      render

      assert_select 'form[action=?][method=?]', prayer_requests_path, 'post' do
        assert_select 'input[name=?]', 'prayer_request[status]', count: 0
      end
    end

    it 'renders the is_anonymous checkbox defaulted to anonymous in the create prayer_request form' do
      prayer_request = PrayerRequest.new
      assign(:prayer_request, prayer_request)

      render

      assert_select 'form[action=?][method=?]', prayer_requests_path, 'post' do
        assert_select 'input[type=?][checked=?][name=?]', 'checkbox', 'checked', 'prayer_request[is_anonymous]'
      end
    end
  end

  context 'user creating their own prayer request' do
    before { sign_in user1 }

    it 'renders the request field in the create prayer_request form' do
      prayer_request = PrayerRequest.new
      assign(:prayer_request, prayer_request)

      render

      assert_select 'form[action=?][method=?]', prayer_requests_path, 'post' do
        assert_select 'input[name=?]', 'prayer_request[request]'
      end
    end

    it 'does not render the status field in the create prayer_request form' do
      prayer_request = PrayerRequest.new
      assign(:prayer_request, prayer_request)

      render

      assert_select 'form[action=?][method=?]', prayer_requests_path, 'post' do
        assert_select 'input[name=?]', 'prayer_request[status]', count: 0
      end
    end

    it 'renders the is_anonymous checkbox defaulted to anonymous in the create prayer_request form' do
      prayer_request = PrayerRequest.new
      assign(:prayer_request, prayer_request)

      render

      assert_select 'form[action=?][method=?]', prayer_requests_path, 'post' do
        assert_select 'input[type=?][checked=?][name=?]', 'checkbox', 'checked', 'prayer_request[is_anonymous]'
      end
    end
  end
end
