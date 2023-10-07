require 'rails_helper'

RSpec.describe "users/new", type: :view do
  before(:each) do
    user = User.create!(email: "test@gmail.com")
    assign(:user, user.new(user: user))
  end

  it "renders new user form" do
    render

    assert_select "form[action=?][method=?]", users_path, "post" do
    end
  end
end
