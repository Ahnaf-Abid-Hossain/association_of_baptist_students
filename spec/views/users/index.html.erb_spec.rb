require 'rails_helper'

RSpec.describe "users/index", type: :view do
  before(:each) do
    user1 = FactoryBot.create(:user, email: "test1@gmail.com")
    user2 = FactoryBot.create(:user, email: "test2@gmail.com")
    assign(:users, [user1, user2])
  end

  it "renders a list of users" do
    render
    Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
  end
end
