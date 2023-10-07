require 'rails_helper'

RSpec.describe "users/index", type: :view do
  before(:each) do
    user1 = User.create!(email: "test1@gmail.com")
    user2 = User.create!(email: "test2@gmail.com")
    assign(:users, [
      user.create!(user: user1),
      user.create!(user: user2)
    ])
  end

  it "renders a list of users" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
  end
end
