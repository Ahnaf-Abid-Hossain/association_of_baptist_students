=begin
require 'rails_helper'

RSpec.describe "prayer_requests/edit", type: :view do
  let(:prayer_request) {
    PrayerRequest.create!(
      request: "MyString",
      status: "MyString",
      alumni: nil
    )
  }

  before(:each) do
    assign(:prayer_request, prayer_request)
  end

  it "renders the edit prayer_request form" do
    render

    assert_select "form[action=?][method=?]", prayer_request_path(prayer_request), "post" do

      assert_select "input[name=?]", "prayer_request[request]"

      assert_select "input[name=?]", "prayer_request[status]"

      assert_select "input[name=?]", "prayer_request[alumni_id]"
    end
  end
end
=end