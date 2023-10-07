=begin
require 'rails_helper'

RSpec.describe "prayer_requests/show", type: :view do
  before(:each) do
    assign(:prayer_request, PrayerRequest.create!(
      request: "Request",
      status: "Status",
      user: nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Request/)
    expect(rendered).to match(/Status/)
    expect(rendered).to match(//)
  end
end
=end