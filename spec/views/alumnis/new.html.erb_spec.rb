require 'rails_helper'

RSpec.describe "alumnis/new", type: :view do
  before(:each) do
    user = User.create!(email: "test@gmail.com")
    assign(:alumni, Alumni.new(user: user))
  end

  it "renders new alumni form" do
    render

    assert_select "form[action=?][method=?]", alumnis_path, "post" do
    end
  end
end
