require 'rails_helper'

RSpec.describe('alumnis/index') do
  before do
    # Create two alumni
    alumni1 = FactoryBot.create(:alumni, alum_email: "alum1@gmail.com")
    alumni2 = FactoryBot.create(:alumni, alum_email: "alum2@gmail.com")

    # Attach them to the view
    assign(:alumnis, [alumni1, alumni2])

    # Sign in as the first alumni
    sign_in alumni1.user
  end

  it 'renders a list of alumnis' do
    render
    Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
  end
end
