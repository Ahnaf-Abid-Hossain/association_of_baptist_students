require 'rails_helper'

RSpec.describe('alumnis/edit') do
  before do
    user = FactoryBot.create(:user)
    assign(:alumni, user)
    sign_in user
  end

  it 'renders the edit alumni form' do
    render

    assert_select 'form[action=?][method=?]', alumni_path(alumni), 'post'
    # do ... end
  end
end
