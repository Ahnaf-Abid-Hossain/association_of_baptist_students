require 'rails_helper'

RSpec.describe('prayer_requests/edit') do
  let!(:user1) { FactoryBot.create(:user, email: 'user1@gmail.com') }
  let!(:admin) { FactoryBot.create(:admin_user, email: 'admin@gmail.com') }

  after do
    user1.destroy!
    admin.destroy!
  end

  context 'admin editing their prayer request' do
    before { sign_in admin }

    it 'renders the request field in the edit prayer_request form' do
      prayer_request = FactoryBot.create(:prayer_request, user: admin, is_anonymous: true)
      assign(:prayer_request, prayer_request)

      render

      assert_select 'form[action=?][method=?]', prayer_request_path(prayer_request), 'post' do
        assert_select 'textarea[name=?]', 'prayer_request[request]'
      end
    end

    it 'does not render the status field in the edit prayer_request form' do
      prayer_request = FactoryBot.create(:prayer_request, user: admin, is_anonymous: true)
      assign(:prayer_request, prayer_request)

      render

      assert_select 'form[action=?][method=?]', prayer_request_path(prayer_request), 'post' do
        assert_select 'textarea[name=?]', 'prayer_request[status]', count: 0
      end
    end

    it 'renders the anonymous field in the edit prayer_request form' do
      prayer_request = FactoryBot.create(:prayer_request, user: admin, is_anonymous: true)
      assign(:prayer_request, prayer_request)

      render

      assert_select 'form[action=?][method=?]', prayer_request_path(prayer_request), 'post' do
        assert_select 'textarea[name=?]', 'prayer_request[status]', count: 0
      end
    end

    it 'does renders the is_anonymous checkbox in the edit prayer_request form' do
      prayer_request1 = FactoryBot.create(:prayer_request, user: admin, is_anonymous: true)
      prayer_request2 = FactoryBot.create(:prayer_request, user: admin, is_anonymous: false)

      assign(:prayer_request, prayer_request1)

      render

      assert_select 'form[action=?][method=?]', prayer_request_path(prayer_request1), 'post' do
        assert_select 'input[type=?][checked=?][name=?]', 'checkbox', 'checked', 'prayer_request[is_anonymous]'
      end

      assign(:prayer_request, prayer_request2)

      render

      assert_select 'form[action=?][method=?]', prayer_request_path(prayer_request2), 'post' do
        assert_select 'input[type=?][checked=?][name=?]', 'checkbox', 'checked', 'prayer_request[is_anonymous]', count: 0
      end
    end

    it 'does renders the is_public checkbox in the edit prayer_request form' do
      prayer_request1 = FactoryBot.create(:prayer_request, user: admin, is_public: true)
      prayer_request2 = FactoryBot.create(:prayer_request, user: admin, is_public: false)

      assign(:prayer_request, prayer_request1)

      render

      assert_select 'form[action=?][method=?]', prayer_request_path(prayer_request1), 'post' do
        assert_select 'input[type=?][checked=?][name=?]', 'checkbox', 'checked', 'prayer_request[is_public]'
      end

      assign(:prayer_request, prayer_request2)

      render

      assert_select 'form[action=?][method=?]', prayer_request_path(prayer_request2), 'post' do
        assert_select 'input[type=?][checked=?][name=?]', 'checkbox', 'checked', 'prayer_request[is_public]', count: 0
      end
    end
  end

  context 'admin editing user prayer request' do
    before { sign_in admin }

    it 'does not render the request field in the edit prayer_request form' do
      prayer_request = FactoryBot.create(:prayer_request, user: user1)
      assign(:prayer_request, prayer_request)

      render

      assert_select 'form[action=?][method=?]', prayer_request_path(prayer_request), 'post' do
        assert_select 'input[name=?]', 'prayer_request[request]', count: 0
      end
    end

    it 'does not render the is_anonymous checkbox in the edit prayer_request form' do
      prayer_request = FactoryBot.create(:prayer_request, user: user1)
      assign(:prayer_request, prayer_request)

      render

      assert_select 'form[action=?][method=?]', prayer_request_path(prayer_request), 'post' do
        assert_select 'input[type=?][name=?]', 'checkbox', 'prayer_request[is_anonymous]', count: 0
      end
    end

    it 'does not render the is_public checkbox in the edit prayer_request form' do
      prayer_request = FactoryBot.create(:prayer_request, user: user1)
      assign(:prayer_request, prayer_request)

      render

      assert_select 'form[action=?][method=?]', prayer_request_path(prayer_request), 'post' do
        assert_select 'input[type=?][name=?]', 'checkbox', 'prayer_request[is_public]', count: 0
      end
    end
  end

  context 'user editing their prayer request' do
    before { sign_in user1 }

    it 'renders the request field in the edit prayer_request form' do
      prayer_request = FactoryBot.create(:prayer_request, user: user1, is_anonymous: true)
      assign(:prayer_request, prayer_request)

      render

      assert_select 'form[action=?][method=?]', prayer_request_path(prayer_request), 'post' do
        assert_select 'textarea[name=?]', 'prayer_request[request]'
      end
    end

    it 'does not render the status field in the edit prayer_request form' do
      prayer_request = FactoryBot.create(:prayer_request, user: user1, is_anonymous: true)
      assign(:prayer_request, prayer_request)

      render

      assert_select 'form[action=?][method=?]', prayer_request_path(prayer_request), 'post' do
        assert_select 'input[name=?]', 'prayer_request[status]', count: 0
      end
    end

    it 'does renders the is_anonymous checkbox in the edit prayer_request form' do
      prayer_request1 = FactoryBot.create(:prayer_request, user: user1, is_anonymous: true)
      prayer_request2 = FactoryBot.create(:prayer_request, user: user1, is_anonymous: false)

      assign(:prayer_request, prayer_request1)

      render

      assert_select 'form[action=?][method=?]', prayer_request_path(prayer_request1), 'post' do
        assert_select 'input[type=?][checked=?][name=?]', 'checkbox', 'checked', 'prayer_request[is_anonymous]'
      end

      assign(:prayer_request, prayer_request2)

      render

      assert_select 'form[action=?][method=?]', prayer_request_path(prayer_request2), 'post' do
        assert_select 'input[type=?][checked=?][name=?]', 'checkbox', 'checked', 'prayer_request[is_anonymous]', count: 0
      end
    end

    it 'does renders the is_public checkbox in the edit prayer_request form' do
      prayer_request1 = FactoryBot.create(:prayer_request, user: user1, is_public: true)
      prayer_request2 = FactoryBot.create(:prayer_request, user: user1, is_public: false)

      assign(:prayer_request, prayer_request1)

      render

      assert_select 'form[action=?][method=?]', prayer_request_path(prayer_request1), 'post' do
        assert_select 'input[type=?][checked=?][name=?]', 'checkbox', 'checked', 'prayer_request[is_public]'
      end

      assign(:prayer_request, prayer_request2)

      render

      assert_select 'form[action=?][method=?]', prayer_request_path(prayer_request2), 'post' do
        assert_select 'input[type=?][checked=?][name=?]', 'checkbox', 'checked', 'prayer_request[is_public]', count: 0
      end
    end
  end
end
