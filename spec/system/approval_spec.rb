require 'rails_helper'
require 'capybara/rspec'

RSpec.describe('/approvals/show_users') do
  before do
    driven_by(:rack_test)
    @author = FactoryBot.create(:admin_user)
    @user = FactoryBot.create(:user2)
  end

  it 'admin status can be toggled' do
    # Assuming you have a user and you are logged in
    sign_in @author
    initial_is_admin = @user.is_admin
    visit '/approvals/show_users'
    # Find the "Admin Toggler" button by its ID or CSS selector
    find("#approve-button-#{@user.user_first_name}-#{@user.user_last_name}").click

    # Check if the admin status has been toggled as expected
    expect(page).to(have_content('Alumni made admin successfully.')) # Modify this to match your actual success message
    @user.reload # Reload the author to get the latest data from the database
    expect(@user.is_admin).not_to(eq(initial_is_admin))
  end

  it 'admin cant switch himself' do
    # Assuming you have a user and you are logged in
    sign_in @author
    initial_is_admin = @author.is_admin
    visit '/approvals/show_users'
    # Find the "Admin Toggler" button by its ID or CSS selector
    find("#approve-button-#{@author.user_first_name}-#{@author.user_last_name}").click

    # Check if the admin status has been toggled as expected
    expect(page).to(have_content("You can't modify your own admin status")) # Modify this to match your actual success message
    @author.reload # Reload the author to get the latest data from the database
    expect(@author.is_admin).to(eq(initial_is_admin))
  end

  it 'display completed profiles needing approval' do
    # Sign in as an admin
    sign_in @author

    # Create a user with a completed profile
    FactoryBot.create(:user, approval_status: 0)

    # Visit the approvals page and expect the user to be there
    visit '/approvals/index'
    expect(page).to(have_css('tbody > tr', count: 1))
  end

  it 'does not display incomplete profiles needing approval' do
    # Sign in as an admin
    sign_in @author

    # Create a user with an incomplete profile
    FactoryBot.create(:user, approval_status: 0, user_first_name: '', user_last_name: '')

    # Visit the approvals page and expect the user to not be there (no rows)
    visit '/approvals/index'
    expect(page).not_to(have_css('tbody > tr'))
  end
end
