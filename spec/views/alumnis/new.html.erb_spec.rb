require 'rails_helper'

RSpec.describe('alumnis/new') do
  before do
    user = FactoryBot.create(:user)
    assign(:alumni, user)
    sign_in user
  end

  it 'renders new alumni form' do
    render

    assert_select 'form[action=?][method=?]', alumnis_path, 'post'
    # do ... end
  end
end
