require 'rails_helper'

# Used for creating a factory bot link w/ admin user
def make_link(**kwargs)
  admin_user = User.find_by(email: 'admin@gmail.com')
  FactoryBot.create(:link, user: admin_user, **kwargs)
end

# Used to sign in as admin
def sign_in_admin
  admin_user = User.find_by(email: 'admin@gmail.com')
  sign_in(admin_user)
  admin_user
end

RSpec.describe('Links') do
  before do
    driven_by(:rack_test)

    # Sign in
    user = FactoryBot.create(:user)
    sign_in user

    # Create an admin user for testing
    FactoryBot.create(:admin_user, email: 'admin@gmail.com')
  end

  context 'viewing links' do
    it 'displays new links' do
      # Create a link
      next_order = (Link.maximum(:order) || 0) + 1
      link = make_link(order: next_order)

      # Visit home page
      visit '/'

      # Test for link
      expect(page).to(have_link(link.label, href: link.url))
    end

    it 'displays links bar with CSS' do
      # Visit home page
      visit '/'

      # Test for .quick-links element
      expect(page).to(have_css('div.quick-links'))
    end

    pending 'displays links in order'
  end

  context 'making links' do
    it 'allows admins to try to make new links' do
      # Promote ourself to admin
      sign_in_admin

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
      admin_user = sign_in_admin

      # Ensure we actually created one Link
      expect do
        # POST to links page
        post('/links', params: {
          link: {
            label: 'Test',
            url: 'https://test.com',
            order: 800_000
          }
        }
        )

        # Expect to be able to create link
        expect(response).to(have_http_status(:found))

        # Expect the latest link to be authored by us
        link = Link.last
        expect(link.user).to(eq(admin_user))
      end.to(change(Link, :count).by(1))
    end

    it 'shows the author of a link' do
      # Promote ourself to admin
      sign_in_admin

      # Create a link
      link = make_link

      # View link
      visit link_path(link)

      # Expect to see a link to the author
      author_name = "#{link.user.user_first_name} #{link.user.user_last_name}"
      expect(page).to(have_link(author_name, href: user_path(link.user)))
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

    it 'handles bad link creations' do
      # Promote ourself to admin
      sign_in_admin

      # Create (bad) link data
      data = {
        link: {
          label: 'Test',
          url: 'https://test.com',
          order: -8
        }
      }

      # POST link create page
      post links_path, params: data

      # Expect to be OK
      expect(response).to(have_http_status(:unprocessable_entity))
    end
  end

  context 'deleting links' do
    it 'allows admins to delete links' do
      # Promote ourself to admin
      sign_in_admin

      # Create link to delete
      link = make_link

      # Ensure that deletion does remove one Link
      expect do
        # DELETE to link
        delete(link_path(link))

        # Expect to be accepted
        expect(response).to(have_http_status(:found))
      end.to(change(Link, :count).by(-1))
    end

    it 'prevents non-admins from deleting links' do
      # Create link to delete
      link = make_link

      # DELETE to link
      delete link_path(link)

      # Expect to be forbidden
      expect(response).to(have_http_status(:forbidden))
    end
  end

  context 'editing links' do
    it 'allows admins to try to edit links' do
      # Promote ourself to admin
      sign_in_admin

      # Create link to edit
      link = make_link

      # GET link edit page
      get edit_link_path(link)

      # Expect to be allowed into the edit page
      expect(response).to(have_http_status(:ok))
    end

    it 'prevents non-admins from trying to edit links' do
      # Create link to edit
      link = make_link

      # GET link edit page
      get edit_link_path(link)

      # Expect to be directed away
      expect(response).to(redirect_to('/'))
    end

    it 'allows admins to actually edit links url' do
      # Promote ourself to admin
      sign_in_admin

      # Create link to edit
      link = make_link

      # Create edit data
      data = {
        link: {
          url: 'http://silly.gov'
        }
      }

      # PATCH link edit page
      patch link_path(link), params: data

      # Expect to be OK
      expect(response).to(have_http_status(:found))

      # Expect link to now have URL silly.gov
      link = Link.find(link.id)
      expect(link).not_to(be_nil)
      expect(link.url).to(eq('http://silly.gov'))
    end

    it 'allows admins to actually edit links label' do
      # Promote ourself to admin
      sign_in_admin

      # Create link to edit
      link = make_link

      # Create edit data
      data = {
        link: {
          label: 'Hello'
        }
      }

      # PATCH link edit page
      patch link_path(link), params: data

      # Expect to be OK
      expect(response).to(have_http_status(:found))

      # Expect link to now have label Hello
      link = Link.find(link.id)
      expect(link).not_to(be_nil)
      expect(link.label).to(eq('Hello'))
    end

    it 'allows admins to actually edit links order' do
      # Promote ourself to admin
      sign_in_admin

      # Create link to edit
      link = make_link

      # Create edit data
      data = {
        link: {
          order: 80
        }
      }

      # PATCH link edit page
      patch link_path(link), params: data

      # Expect to be OK
      expect(response).to(have_http_status(:found))

      # Expect link to now have order 80
      link = Link.find(link.id)
      expect(link).not_to(be_nil)
      expect(link.order).to(eq(80))
    end

    it 'handles bad link edits' do
      # Promote ourself to admin
      sign_in_admin

      # Create link to edit
      link = make_link

      # Create (bad) edit data
      data = {
        link: {
          order: -8
        }
      }

      # PATCH link edit page
      patch link_path(link), params: data

      # Expect to be OK
      expect(response).to(have_http_status(:unprocessable_entity))
    end

    it 'prevents non-admins from actually editing links' do
      # Create link to edit
      link = make_link

      # Create edit data
      data = {
        link: {
          label: 'New Test',
          url: 'http://silly.gov',
          order: 80
        }
      }

      # PATCH link edit page
      patch link_path(link), params: data

      # Expect to be forbidden
      expect(response).to(have_http_status(:forbidden))

      # PUT link edit page
      put link_path(link), params: data

      # Expect to be forbidden
      expect(response).to(have_http_status(:forbidden))
    end
  end
end
