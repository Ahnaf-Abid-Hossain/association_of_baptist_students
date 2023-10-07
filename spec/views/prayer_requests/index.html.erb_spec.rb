=begin
require 'rails_helper'

RSpec.describe "prayer_requests/index", type: :view do
  before(:each) do
    assign(:prayer_requests, [
      PrayerRequest.create!(
        request: "Request",
        status: "Status",
        user: nil
      ),
      PrayerRequest.create!(
        request: "Request",
        status: "Status",
        user: nil
      )
    ])
  end

  it "renders a list of prayer_requests" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new("Request".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Status".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
  end
end
=end