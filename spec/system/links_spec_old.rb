require 'rails_helper'

RSpec.describe('Links') do
  context 'editing links' do
    let(:link) do
      link = make_link(admin_user)
    end

    it 'allows admins to try to edit links' do
      # Promote ourself to admin
      sign_in admin_user

      # GET link edit page
      get edit_link_path(link)

      # Expect to be allowed into the edit page
      expect(response).to(have_http_status(:ok))
    end

    it 'prevents non-admins from trying to edit links' do
      # GET link edit page
      get edit_link_path(link)

      # Expect to be directed away
      expect(response).to(redirect_to('/'))
    end

    it 'allows admins to actually edit links url' do
      # Promote ourself to admin
      sign_in admin_user

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
      sign_in admin_user

      # Create four links
      # Expect links to not be nil
      link1 = make_link(admin_user, order: 1)
      expect(link1).to_not(be(nil))

      link2 = make_link(admin_user, order: 2)
      expect(link2).to_not(be(nil))

      link3 = make_link(admin_user, order: 3)
      expect(link3).to_not(be(nil))

      link4 = make_link(admin_user, order: 4)
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
      link1 = make_link(admin_user, order: 1)
      expect(link1).to_not(be(nil))

      link2 = make_link(admin_user, order: 2)
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
