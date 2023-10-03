require 'rails_helper'

RSpec.describe('Quick Links') do
  before do
    driven_by(:rack_test)

    # Sign in
    user = FactoryBot.create(:user)
    sign_in user
  end

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
