require 'rails_helper'

RSpec.describe('alumnis/edit') do
  let(:alumni) do
    alumni = FactoryBot.create(:alumni)
  end

  before do
    assign(:alumni, alumni)
    sign_in alumni.user
  end

  it 'renders the edit alumni form' do
    render

    assert_select 'form[action=?][method=?]', alumni_path(alumni), 'post'
    # do ... end
  end
end
