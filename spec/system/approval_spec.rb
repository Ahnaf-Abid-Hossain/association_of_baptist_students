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
end
