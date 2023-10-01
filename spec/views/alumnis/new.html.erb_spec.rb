require 'rails_helper'

RSpec.describe('alumnis/new') do
  before do
    # Create new alumni
    alumni = Alumni.new

    # Attach it to the view
    assign(:alumni, alumni)

    # Sign in as a user
    sign_in FactoryBot.create(:user)
  end

  it 'renders new alumni form' do
    render

    assert_select 'form[action=?][method=?]', alumnis_path, 'post'
    # do ... end
  end
end
