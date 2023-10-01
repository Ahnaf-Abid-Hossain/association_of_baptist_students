require 'rails_helper'

RSpec.describe('alumnis/show') do
  before do
    # Create an alumni
    alumni = FactoryBot.create(:alumni)

    # Attach it to the view
    assign(:alumni, alumni)

    # Attach empty meeting notes list to view
    assign(:meeting_notes, [])

    # Sign in as this alumni's user
    sign_in alumni.user
  end

  it 'renders attributes in <p>' do
    render
  end
end
