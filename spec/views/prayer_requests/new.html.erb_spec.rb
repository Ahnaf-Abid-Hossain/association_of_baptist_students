require 'rails_helper'

RSpec.describe('prayer_requests/new') do
  let!(:user1) { FactoryBot.create(:user, email: 'user1@gmail.com') }
  let!(:admin) { FactoryBot.create(:admin_user, email: 'admin@gmail.com') }

  after do
    user1.destroy!
    admin.destroy!
  end

  context 'admin creating their own prayer request' do
    before do 
      sign_in admin
      prayer_request = PrayerRequest.new
      assign(:prayer_request, prayer_request)
      render
    end  

    it 'renders the request field in the create prayer_request form' do
      assert_select 'form[action=?][method=?]', prayer_requests_path, 'post' do
        assert_select 'textarea[name=?]', 'prayer_request[request]'
      end
    end

    it 'does not render the status field in the create prayer_request form' do
      assert_select 'form[action=?][method=?]', prayer_requests_path, 'post' do
        assert_select 'input[name=?]', 'prayer_request[status]', count: 0
      end
    end

    it 'renders the is_anonymous checkbox defaulted to anonymous in the create prayer_request form' do
      assert_select 'form[action=?][method=?]', prayer_requests_path, 'post' do
        assert_select 'input[type=?][checked=?][name=?]', 'checkbox', 'checked', 'prayer_request[is_anonymous]'
      end
    end

    it 'renders the is_public checkbox defaulted to not public in the create prayer_request form' do
      assert_select 'form[action=?][method=?]', prayer_requests_path, 'post' do
        assert_select 'input[type=?][checked=?][name=?]', 'checkbox', 'checked', 'prayer_request[is_public]', count: 0
        assert_select 'input[type=?][name=?]', 'checkbox', 'prayer_request[is_public]'
      end
    end
  end

  context 'user creating their own prayer request' do
    before do 
      sign_in user1
      prayer_request = PrayerRequest.new
      assign(:prayer_request, prayer_request)
      render
    end

    it 'renders the request field in the create prayer_request form' do
      assert_select 'form[action=?][method=?]', prayer_requests_path, 'post' do
        assert_select 'textarea[name=?]', 'prayer_request[request]'
      end
    end

    it 'does not render the status field in the create prayer_request form' do
      assert_select 'form[action=?][method=?]', prayer_requests_path, 'post' do
        assert_select 'input[name=?]', 'prayer_request[status]', count: 0
      end
    end

    it 'renders the is_anonymous checkbox defaulted to anonymous in the create prayer_request form' do
      assert_select 'form[action=?][method=?]', prayer_requests_path, 'post' do
        assert_select 'input[type=?][checked=?][name=?]', 'checkbox', 'checked', 'prayer_request[is_anonymous]'
      end
    end

    it 'renders the is_public checkbox defaulted to not public in the create prayer_request form' do
      assert_select 'form[action=?][method=?]', prayer_requests_path, 'post' do
        assert_select 'input[type=?][checked=?][name=?]', 'checkbox', 'checked', 'prayer_request[is_public]', count: 0
        assert_select 'input[type=?][name=?]', 'checkbox', 'prayer_request[is_public]'
      end
    end
  end
end
