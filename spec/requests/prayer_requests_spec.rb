require 'rails_helper'

RSpec.describe('/prayer_requests') do
  let!(:user1) { FactoryBot.create(:user, email: 'user1@gmail.com') }
  let!(:user2) { FactoryBot.create(:user, email: 'user2@gmail.com') }
  let!(:admin) { FactoryBot.create(:admin_user, email: 'admin@gmail.com') }

  after do
    user1.destroy!
    user2.destroy!
    admin.destroy!
  end

  describe 'GET /index' do
    it 'renders a successful response for admins' do
      sign_in admin
      prayer_request = FactoryBot.create(:prayer_request, user: admin)
      get prayer_requests_url
      expect(response).to(be_successful)
    end

    it 'renders a successful response for users' do
      sign_in user1
      prayer_request = FactoryBot.create(:prayer_request, user: admin)
      get prayer_requests_url
      expect(response).to(be_successful)
    end
  end

  describe 'GET /show' do
    context 'when viewing prayer requests' do
      it 'renders a successful response for admins' do
        sign_in admin
        prayer_request = FactoryBot.create(:prayer_request, user: admin)
        get prayer_request_url(prayer_request)
        expect(response).to(be_successful)
      end

      it 'renders a successful response for users viewing their own prayer requests' do
        sign_in user1
        prayer_request = FactoryBot.create(:prayer_request, user: user1)
        get prayer_request_url(prayer_request)
        expect(response).to(be_successful)
      end

      it "renders an unsuccessful response for users trying to view other users' private prayer requests" do
        sign_in user1
        prayer_request = FactoryBot.create(:prayer_request, user: user2, is_public: false)
        get prayer_request_url(prayer_request)
        expect(response).not_to(be_successful)
      end

      it "renders a successful response for users trying to view other users' public prayer requests" do
        sign_in user1
        prayer_request = FactoryBot.create(:prayer_request, user: user2, is_public: true)
        get prayer_request_url(prayer_request)
        expect(response).to(be_successful)
      end

      it 'renders a successful response for admins viewing other users prayer requests' do
        sign_in admin
        prayer_request = FactoryBot.create(:prayer_request, user: user1)
        get prayer_request_url(prayer_request)
        expect(response).to(be_successful)
      end

      it 'correctly updates the prayer request status when viewed by an admin' do
        sign_in admin
        prayer_request = FactoryBot.create(:prayer_request, user: user1)

        prev_status = prayer_request.status
        expect(prev_status).to eq('Not Read')

        get prayer_request_url(prayer_request)

        expect(prayer_request.reload.status).to eq('Read')
      end
    end
  end

  describe 'GET /new' do
    context 'when creating new prayer requests' do
      it 'renders a successful response for admins' do
        sign_in admin
        get new_prayer_request_url
        expect(response).to(be_successful)
      end

      it 'renders a successful response for users' do
        sign_in user1
        get new_prayer_request_url
        expect(response).to(be_successful)
      end
    end
  end

  describe 'GET /edit' do
    context 'when editing prayer requests' do
      it 'renders a successful response for admins editing their own prayer requests' do
        sign_in admin
        prayer_request = FactoryBot.create(:prayer_request, user: admin)
        get edit_prayer_request_url(prayer_request)
        expect(response).to(be_successful)
      end

      it 'renders a successful response for admins editing other users prayer requests' do
        sign_in admin
        prayer_request = FactoryBot.create(:prayer_request, user: user1)
        get edit_prayer_request_url(prayer_request)
        expect(response).to(be_successful)
      end

      it 'renders a successful response for users editing their own prayer requests' do
        sign_in user1
        prayer_request = FactoryBot.create(:prayer_request, user: user1)
        get edit_prayer_request_url(prayer_request)
        expect(response).to(be_successful)
      end

      it "renders an unsuccessful response for users trying to edit other users' prayer requests" do
        sign_in user1
        prayer_request = FactoryBot.create(:prayer_request, user: user2)
        get edit_prayer_request_url(prayer_request)
        expect(response).not_to(be_successful)
      end
    end
  end

  describe 'POST /create' do
    context 'when admins are creating new prayer requests' do
      before { sign_in admin }

      it 'creates a new prayer request if using valid parameters' do
        prayer_request = FactoryBot.build(:prayer_request)
        expect do
          post(prayer_requests_url, params: { prayer_request: prayer_request.attributes })
        end.to(change(PrayerRequest, :count).by(1))
      end

      it 'redirects to the created prayer request if using valid parameters' do
        prayer_request = FactoryBot.build(:prayer_request)
        post prayer_requests_url, params: { prayer_request: prayer_request.attributes }
        expect(response).to(redirect_to(prayer_request_url(PrayerRequest.last)))
      end

      it 'does not create a new prayer request if using invalid parameters (no request)' do
        prayer_request = FactoryBot.build(:invalid_prayer_request_no_request)
        expect do
          post(prayer_requests_url, params: { prayer_request: prayer_request.attributes })
        end.not_to(change(PrayerRequest, :count))
      end
    end

    context 'when users are creating new prayer requests' do
      before { sign_in user1 }

      it 'creates a new prayer request for if using valid parameters' do
        prayer_request = FactoryBot.build(:prayer_request)
        expect do
          post(prayer_requests_url, params: { prayer_request: prayer_request.attributes })
        end.to(change(PrayerRequest, :count).by(1))
      end

      it 'redirects to the created prayer request if using valid parameters' do
        prayer_request = FactoryBot.build(:prayer_request)
        post prayer_requests_url, params: { prayer_request: prayer_request.attributes }
        expect(response).to(redirect_to(prayer_request_url(PrayerRequest.last)))
      end

      it 'does not create a new prayer request if using invalid parameters (no request)' do
        prayer_request = FactoryBot.build(:invalid_prayer_request_no_request)
        expect do
          post(prayer_requests_url, params: { prayer_request: prayer_request.attributes })
        end.not_to(change(PrayerRequest, :count))
      end
    end
  end

  describe 'PATCH /update' do
    context 'when updating prayer requests' do
      it 'updates the requested prayer request for admins with valid parameters' do
        sign_in admin
        prayer_request = FactoryBot.create(:prayer_request, user: admin)
        updated_request = 'Updated request'
        updated_status = 'Read'
        updated_prayer_request = FactoryBot.build(:prayer_request, request: updated_request, status: updated_status)

        patch prayer_request_url(prayer_request), params: { prayer_request: updated_prayer_request.attributes }
        prayer_request.reload

        expect(prayer_request.request).to(eq(updated_request))
        expect(prayer_request.status).to(eq(updated_status))
      end

      it 'redirects to the updated prayer request for admins with valid parameters' do
        sign_in admin
        prayer_request = FactoryBot.create(:prayer_request, user: admin)
        updated_request = 'Updated request'
        updated_status = 'Read'
        updated_prayer_request = FactoryBot.build(:prayer_request, request: updated_request, status: updated_status)

        patch prayer_request_url(prayer_request), params: { prayer_request: updated_prayer_request.attributes }
        prayer_request.reload

        expect(response).to(redirect_to(prayer_request_url(prayer_request)))
      end

      it 'renders a response with 422 status for admins with invalid parameters (no request)' do
        sign_in admin
        prayer_request = FactoryBot.create(:prayer_request, user: admin)
        updated_request = nil
        updated_status = 'Read'
        updated_prayer_request = FactoryBot.build(:prayer_request, request: updated_request, status: updated_status)

        patch prayer_request_url(prayer_request), params: { prayer_request: updated_prayer_request.attributes }
        prayer_request.reload

        expect(response).to(have_http_status(:unprocessable_entity))
      end

      it 'renders a response with 422 status for admins with invalid parameters (no status)' do
        sign_in admin
        prayer_request = FactoryBot.create(:prayer_request, user: admin)
        updated_request = 'Updated request'
        updated_status = nil
        updated_prayer_request = FactoryBot.build(:prayer_request, request: updated_request, status: updated_status)

        patch prayer_request_url(prayer_request), params: { prayer_request: updated_prayer_request.attributes }
        prayer_request.reload

        expect(response).to(have_http_status(:unprocessable_entity))
      end

      it "does not allow an admin to modify the 'request' attribute of a User's prayer request" do
        sign_in admin

        prayer_request = FactoryBot.create(:prayer_request, user: user1)
        original_request = prayer_request.request

        updated_request = 'Updated request'
        updated_prayer_request = FactoryBot.build(:prayer_request, request: updated_request)
        patch prayer_request_url(prayer_request), params: { prayer_request: updated_prayer_request.attributes }
        prayer_request.reload

        expect(response).to(redirect_to(prayer_request_url(prayer_request)))
        expect(prayer_request.request).not_to(eq(updated_request))
        expect(prayer_request.request).to(eq(original_request))
      end

      it "does not allow an admin to modify the 'is_anonymous' attribute of a User's prayer request" do
        sign_in admin

        prayer_request = FactoryBot.create(:prayer_request, user: user1, is_anonymous: true)
        original_anonymity = prayer_request.is_anonymous

        updated_anonymity = !original_anonymity
        updated_prayer_request = FactoryBot.build(:prayer_request, is_anonymous: updated_anonymity)
        patch prayer_request_url(prayer_request), params: { prayer_request: updated_prayer_request.attributes }
        prayer_request.reload

        expect(response).to(redirect_to(prayer_request_url(prayer_request)))
        expect(prayer_request.is_anonymous).not_to(eq(updated_anonymity))
        expect(prayer_request.is_anonymous).to(eq(original_anonymity))
      end

      it "does not allow an admin to modify the 'is_public' attribute of a User's prayer request" do
        sign_in admin

        prayer_request = FactoryBot.create(:prayer_request, user: user1, is_public: true)
        original_publicity = prayer_request.is_public

        updated_publicity = !original_publicity
        updated_prayer_request = FactoryBot.build(:prayer_request, is_public: updated_publicity)
        patch prayer_request_url(prayer_request), params: { prayer_request: updated_prayer_request.attributes }
        prayer_request.reload

        expect(response).to(redirect_to(prayer_request_url(prayer_request)))
        expect(prayer_request.is_public).not_to(eq(updated_publicity))
        expect(prayer_request.is_public).to(eq(original_publicity))
      end

      it 'updates the requested PrayerRequest for users with valid parameters' do
        sign_in user1
        prayer_request = FactoryBot.create(:prayer_request, user: user1)
        updated_request = 'Updated request'
        updated_prayer_request = FactoryBot.build(:prayer_request, request: updated_request)

        patch prayer_request_url(prayer_request), params: { prayer_request: updated_prayer_request.attributes }
        prayer_request.reload

        expect(prayer_request.request).to(eq(updated_request))
      end

      it 'redirects to the updated PrayerRequest for users with valid parameters' do
        sign_in user1
        prayer_request = FactoryBot.create(:prayer_request, user: user1)
        updated_request = 'Updated request'
        updated_prayer_request = FactoryBot.build(:prayer_request, request: updated_request)

        patch prayer_request_url(prayer_request), params: { prayer_request: updated_prayer_request.attributes }
        prayer_request.reload

        expect(response).to(redirect_to(prayer_request_url(prayer_request)))
      end

      it 'renders a response with 422 status for users with invalid parameters (no request)' do
        sign_in user1
        prayer_request = FactoryBot.create(:prayer_request, user: user1)
        updated_request = nil
        updated_prayer_request = FactoryBot.build(:prayer_request, request: updated_request)

        patch prayer_request_url(prayer_request), params: { prayer_request: updated_prayer_request.attributes }
        prayer_request.reload

        expect(response).to(have_http_status(:unprocessable_entity))
      end

      it "renders a response with 422 status for users trying to edit other users' prayer requests" do
        sign_in user1
        prayer_request = FactoryBot.create(:prayer_request, user: user2)
        updated_request = 'Updated request'
        updated_prayer_request = FactoryBot.build(:prayer_request, request: updated_request)

        patch prayer_request_url(prayer_request), params: { prayer_request: updated_prayer_request.attributes }
        prayer_request.reload

        expect(response).to(have_http_status(:unprocessable_entity))
      end
    end
  end

  describe 'DELETE /destroy' do
    context 'when destroying prayer requests' do
      it 'successfully destroys prayer requests for admins' do
        sign_in admin
        prayer_request = FactoryBot.create(:prayer_request, user: admin)
        expect do
          delete(prayer_request_url(prayer_request))
        end.to(change(PrayerRequest, :count).by(-1))
      end

      it 'successfully destroys prayer requests for users' do
        sign_in user1
        prayer_request = FactoryBot.create(:prayer_request, user: user1)
        expect do
          delete(prayer_request_url(prayer_request))
        end.to(change(PrayerRequest, :count).by(-1))
      end

      it "fails to destroy other users' prayer requests for users" do
        sign_in user1
        prayer_request = FactoryBot.create(:prayer_request, user: user2)
        expect do
          delete(prayer_request_url(prayer_request))
        end.not_to(change(PrayerRequest, :count))
      end
    end
  end
end
