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

    it 'displays built-in links (for non admins)' do
      # Delete all links
      Link.destroy_all

      # Expect 0 links
      expect(Link.count).to(eq(0))
      
      # Visit home page
      visit '/'

      # Test for links in order
      expect(page.find('.quick-links .navbar-link:nth-child(1)')['href']).to(eq(root_path))
      expect(page.find('.quick-links .navbar-link:nth-child(2)')['href']).to(eq(meeting_notes_path))
      expect(page.find('.quick-links .navbar-link:nth-child(3)')['href']).to(eq(prayer_requests_path))

      # Test for no extra links
      expect(page).not_to have_css('.quick-links .navbar-link:nth-child(4)')
    end

    it 'displays built-in links (for admins)' do
      # Promote ourself to admin
      sign_in_admin
      
      # Delete all links
      Link.destroy_all

      # Expect 0 links
      expect(Link.count).to(eq(0))
      
      # Visit home page
      visit '/'

      # Test for links in order
      expect(page.find('.quick-links .navbar-link:nth-child(1)')['href']).to(eq(root_path))
      expect(page.find('.quick-links .navbar-link:nth-child(2)')['href']).to(eq(meeting_notes_path))
      expect(page.find('.quick-links .navbar-link:nth-child(3)')['href']).to(eq(prayer_requests_path))
      expect(page.find('.quick-links .navbar-link:nth-child(4)')['href']).to(eq(approvals_index_path))
      expect(page.find('.quick-links .navbar-link:nth-child(5)')['href']).to(eq(links_path))

      # Test for no extra links
      expect(page).not_to have_css('.quick-links .navbar-link:nth-child(6)')
    end

    it 'displays links in order' do
      # Promote ourself to admin
      sign_in_admin
      
      # Delete all links
      Link.destroy_all

      # Expect 0 links
      expect(Link.count).to(eq(0))

      # Create three links {1, 2, 3}

      link1 = make_link(order: 1)
      expect(link1).to_not(be(nil))

      link2 = make_link(order: 2)
      expect(link2).to_not(be(nil))

      link3 = make_link(order: 3)
      expect(link3).to_not(be(nil))
      
      # Visit home page
      visit '/'

      # Test for links in order
      expect(page.find('.quick-links .navbar-link:nth-child(6)')['href']).to(eq(link1.url))
      expect(page.find('.quick-links .navbar-link:nth-child(7)')['href']).to(eq(link2.url))
      expect(page.find('.quick-links .navbar-link:nth-child(8)')['href']).to(eq(link3.url))
    end
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

    it 'prevents admins from creating empty links' do
      # Promote ourself to admin
      admin_user = sign_in_admin

      # POST to links page
      post('/links', params: {
          link: {
            label: 'Test',
            url: nil
          }
        }
      )

      # Expect to be able to create link
      expect(response).to(have_http_status(:unprocessable_entity))
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

      # View links
      visit links_path

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

    it 'reorders deleted links' do
      # Promote ourself to admin
      sign_in_admin
      
      # Delete all links
      Link.destroy_all

      # Expect 0 links
      expect(Link.count).to(eq(0))

      # Create three links {1, 2, 3}

      link1 = make_link(order: 1)
      expect(link1).to_not(be(nil))

      link2 = make_link(order: 2)
      expect(link2).to_not(be(nil))

      link3 = make_link(order: 3)
      expect(link3).to_not(be(nil))
      
      # Expect 3 links
      expect(Link.count).to(eq(3))

      # DELETE to link2
      delete(link_path(link2))

      # Expect to be accepted
      expect(response).to(have_http_status(:found))
      
      # Expect link1 to still be (order: 1)
      link1_new = Link.find(link1.id)
      expect(link1_new.order).to(eq(1))
      
      # Expect link3 to be (order: 2) now
      link3_new = Link.find(link3.id)
      expect(link3_new.order).to(eq(2))
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

    it 'allows admins to move a link up/down' do
      # Sign in as admin
      sign_in_admin

      # Create four links
      # Expect links to not be nil
      link1 = make_link(order: 1)
      expect(link1).to_not(be(nil))

      link2 = make_link(order: 2)
      expect(link2).to_not(be(nil))

      link3 = make_link(order: 3)
      expect(link3).to_not(be(nil))

      link4 = make_link(order: 4)
      expect(link4).to_not(be(nil))

      # Store original order
      order2_original = link2.order
      expect(order2_original).to(eq(2))

      order3_original = link3.order
      expect(order3_original).to(eq(3))

      # Try to move link3 up (swap 2<->3)
      patch up_link_path(link3)

      # Expect to be "redirected" to links
      expect(response).to(redirect_to(links_path))

      # Expect 2<->3 order swapped
      order2_new = Link.find(link2.id).order
      order3_new = Link.find(link3.id).order
      expect(order2_new).to(eq(order3_original))
      expect(order2_new).to(eq(3))
      expect(order3_new).to(eq(order2_original))
      expect(order3_new).to(eq(2))

      # Try to move link3 back down
      patch down_link_path(link3)

      # Expect to be "redirected" to links
      expect(response).to(redirect_to(links_path))

      # Expect 2<->3 order to be returned to original
      order2_new2 = Link.find(link2.id).order
      order3_new2 = Link.find(link3.id).order
      expect(order2_new2).to(eq(order2_original))
      expect(order2_new2).to(eq(2))
      expect(order3_new2).to(eq(order3_original))
      expect(order3_new2).to(eq(3))
    end

    it 'ignores attempts to move links past end of list' do
      # Sign in as admin
      sign_in_admin

      # Create two links
      # Expect links to not be nil
      link1 = make_link(order: 1)
      expect(link1).to_not(be(nil))

      link2 = make_link(order: 2)
      expect(link2).to_not(be(nil))

      # Expect there to only be two links
      expect(Link.count).to(eq(2))

      # Try to move link1 up
      patch up_link_path(link1)

      # Expect to be ignored
      expect(response).to(have_http_status(:no_content))

      # Try to move link1 down
      patch down_link_path(link2)

      # Expect to be ignored
      expect(response).to(have_http_status(:no_content))
    end

    it 'disallows non-admins from moving a link up/down' do
      # Create a link to edit
      link = make_link

      # Try to move link up
      patch up_link_path(link)

      # Expect to be forbidden
      expect(response).to(have_http_status(:forbidden))

      # Try to move link down
      patch down_link_path(link)

      # Expect to be forbidden
      expect(response).to(have_http_status(:forbidden))
    end
  end
end
