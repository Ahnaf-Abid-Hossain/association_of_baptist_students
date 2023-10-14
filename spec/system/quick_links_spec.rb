require 'rails_helper'

RSpec.describe('Quick Links') do
  before do
    driven_by(:rack_test)

    # Sign in
    user = FactoryBot.create(:user)
    sign_in user
  end

  context 'viewing links' do
    it 'displays new links' do
      # Create a link
      next_order = (Link.maximum(:order) || 0) + 1
      link = Link.create!(label: 'Test Link 77', url: 'testlink77.edu', order: next_order)
  
      # Visit home page
      visit '/'
  
      # Test for link
      expect(page).to(have_link(link.label, href: link.url))
    end

    pending 'displays links in order'
  end

  context 'making links' do
    it 'allows admins to try to make new links' do
      # Promote ourself to admin
      admin = FactoryBot.create(:admin_user)
      sign_in admin

      # GET new link page
      get '/links/new'

      # Expect to be allowed into the new page
      expect(response).to(have_http_status(:ok))
    end

    it 'prevents non-admins from trying to make new links' do
      # GET new link page
      get '/links/new'

      # Expect to be directed away
      expect(response).to(redirect_to('/'))
    end

    it 'allows admins to create links' do
      # Promote ourself to admin
      admin = FactoryBot.create(:admin_user)
      sign_in admin

      # POST to links page
      post '/links', params: {
        link: {
          label: 'Test',
          url: 'https://test.com',
          order: 800_000
        }
      }

      # Expect to be able to create link
      expect(response).to(have_http_status(:found))
    end

    it 'prevents non-admins from creating links' do
      # POST to links page
      post '/links', params: {
        link: {
          label: 'Test',
          url: 'https://test.com',
          order: 800_000
        }
      }

      # Expect to be forbidden
      expect(response).to(have_http_status(:forbidden))
    end
  end

  context 'deleting links' do
    it 'allows admins to delete links' do
      # Promote ourself to admin
      admin = FactoryBot.create(:admin_user)
      sign_in admin

      # Create link to delete
      link = Link.create!(label: 'Test', url: 'https://test.com', order: 800_000)

      # DELETE to link
      delete link_path(link)

      # Expect to be forbidden
      expect(response).to(have_http_status(:found))
    end

    it 'prevents non-admins from deleting links' do
      # Create link to delete
      link = Link.create!(label: 'Test', url: 'https://test.com', order: 800_000)

      # DELETE to link
      delete link_path(link)

      # Expect to be forbidden
      expect(response).to(have_http_status(:forbidden))
    end
  end

  context 'editing links' do
    pending 'allows admins to try to edit links'
    pending 'prevents non-admins from trying to edit links'

    pending 'allows admins to actually edit links'
    pending 'allows admins to actually edit links href'
    pending 'allows admins to actually edit links title'
    pending 'prevents non-admins from actually editing links'
  end
end
