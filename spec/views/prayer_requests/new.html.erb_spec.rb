=begin
require 'rails_helper'

RSpec.describe "prayer_requests/new", type: :view do
  before(:each) do
    assign(:prayer_request, PrayerRequest.new(
      request: "MyString",
      status: "MyString",
      user: nil
    ))
  end

  it "renders new prayer_request form" do
    render

    assert_select "form[action=?][method=?]", prayer_requests_path, "post" do

      assert_select "input[name=?]", "prayer_request[request]"

      assert_select "input[name=?]", "prayer_request[status]"

      assert_select "input[name=?]", "prayer_request[id]"
    end
  end
end
=end