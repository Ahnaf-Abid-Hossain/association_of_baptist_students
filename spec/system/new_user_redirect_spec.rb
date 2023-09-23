require 'rails_helper'

RSpec.describe "New User Redirect", type: :system do
  before do
    driven_by(:rack_test)
  end

  it 'should redirect a new user to profile creation' do
    # Sign in
    user = FactoryBot.create(:user)
    sign_in user

    # Go to the log in page
    get "/users/sign_in"

    # Expect to be redirected to profile creation
    expect(response).to redirect_to("/alumnis/new") 
  end

  it 'should redirect an existing user to the directory page' do
    # Sign in
    user = FactoryBot.create(:user)
    sign_in user

    # Go to the log in page
    get "/users/sign_in"

    # Expect to be redirected to directory page
    expect(response).to redirect_to("/alumnis") 
  end
end