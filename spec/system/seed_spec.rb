require 'rails_helper'

RSpec.describe('Seed') do
  before do
    driven_by(:rack_test)
  end

  it 'contains seeded user' do
    # Check for seeded user
    user = User.find_by(email: "jamsterwes@gmail.com")

    # Expect it to exist
    expect(user).not_to(be_nil)
  end
end
