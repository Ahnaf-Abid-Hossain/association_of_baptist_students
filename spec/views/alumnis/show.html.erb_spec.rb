require 'rails_helper'

RSpec.describe "alumnis/show", type: :view do
  before(:each) do
    user = User.create!(email: "test@gmail.com")
    assign(:alumni, Alumni.create!(user: user))
  end

  it "renders attributes in <p>" do
    render
  end
end
