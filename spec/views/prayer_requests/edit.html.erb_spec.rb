require 'rails_helper'

RSpec.describe "prayer_requests/edit", type: :view do
  before do
    @user1 = FactoryBot.create(:user, email: 'user1@gmail.com')
    @admin = FactoryBot.create(:admin_user, email: 'admin@gmail.com')
  end

  after do
    @user1.destroy!
    @admin.destroy!
  end

  context "admin viewing their own anonymous prayer request" do
    it "renders the edit prayer_request form" do
      sign_in @admin
      prayer_request = FactoryBot.create(:prayer_request, user: @admin, is_anonymous: true)
      assign(:prayer_request, prayer_request)

      render 
      
      assert_select "form[action=?][method=?]", prayer_request_path(prayer_request), "post" do

        assert_select "input[name=?]", "prayer_request[request]"

        assert_select "input[name=?]", "prayer_request[status]"
        
        assert_select "input[type=?][checked=?][name=?]", "checkbox", "checked", "prayer_request[is_anonymous]"
      end
    end
  end

  # context "admin viewing their own non-anonymous prayer request" do
  #   it "renders the edit prayer_request form" do
  #     sign_in @admin
  #     prayer_request = FactoryBot.create(:prayer_request, user: @admin, is_anonymous: false)
  #     assign(:prayer_request, prayer_request)

  #     render 
      
  #     assert_select "form[action=?][method=?]", prayer_request_path(prayer_request), "post" do

  #       assert_select "input[name=?]", "prayer_request[request]"

  #       assert_select "input[name=?]", "prayer_request[status]"
        
  #       assert_select "input[type=?][checked=?][name=?]", "checkbox", "false", "prayer_request[is_anonymous]"
  #     end
  #   end
  # end

  # context "admin viewing anonymous user prayer request" do
  #   it "renders the edit prayer_request form" do
  #     sign_in @admin
  #     prayer_request = FactoryBot.create(:prayer_request, user: @user1, is_anonymous: true)
  #     assign(:prayer_request, prayer_request)

  #     render 
      
  #     assert_select "form[action=?][method=?]", prayer_request_path(prayer_request), "post" do

  #       assert_select "input[name=?]", "prayer_request[request]"

  #       assert_select "input[name=?]", "prayer_request[status]"

  #       assert_no_select "input[type=?][name=?]", "checkbox", "prayer_request[is_anonymous]"
  #     end
  #   end
  # end

  # context "admin viewing non-anonymous user prayer request" do
  #   it "renders the edit prayer_request form" do
  #     sign_in @admin
  #     prayer_request = FactoryBot.create(:prayer_request, user: @user1, is_anonymous: false)
  #     assign(:prayer_request, prayer_request)

  #     render 
      
  #     assert_select "form[action=?][method=?]", prayer_request_path(prayer_request), "post" do

  #       assert_select "input[name=?]", "prayer_request[request]"

  #       assert_select "input[name=?]", "prayer_request[status]"
        
  #       assert_no_select "input[type=?][name=?]", "checkbox", "prayer_request[is_anonymous]"
  #     end
  #   end
  # end

  # context "user viewing their own anonymous prayer request" do
  #   it "renders the edit prayer_request form" do
  #     sign_in @user1
  #     prayer_request = FactoryBot.create(:prayer_request, user: @user1, is_anonymous: true)
  #     assign(:prayer_request, prayer_request)

  #     render 
      
  #     assert_select "form[action=?][method=?]", prayer_request_path(prayer_request), "post" do

  #       assert_select "input[name=?]", "prayer_request[request]"

  #       assert_not_select "input[name=?]", "prayer_request[status]"
        
  #       assert_select "input[type=?][name=?]", "checkbox", "prayer_request[is_anonymous]"
  #     end
  #   end
  # end

  # context "user viewing their own non-anonymous prayer request" do
  #   it "renders the edit prayer_request form" do
  #     sign_in @user1
  #     prayer_request = FactoryBot.create(:prayer_request, user: @user1, is_anonymous: false)
  #     assign(:prayer_request, prayer_request)

  #     render 
      
  #     assert_select "form[action=?][method=?]", prayer_request_path(prayer_request), "post" do

  #       assert_select "input[name=?]", "prayer_request[request]"

  #       assert_not_select "input[name=?]", "prayer_request[status]"
        
  #       assert_select "input[type=?][name=?]", "checkbox", "prayer_request[is_anonymous]"
  #     end
  #   end
  # end
end
