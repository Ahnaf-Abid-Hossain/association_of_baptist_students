require 'rails_helper'

RSpec.describe('alumnis/edit', type: :view) do
  let(:alumni) do
    user = User.create!(email: 'test@gmail.com')
    Alumni.create!(user: user)
  end

  before do
    assign(:alumni, alumni)
  end

  it 'renders the edit alumni form' do
    render

    assert_select 'form[action=?][method=?]', alumni_path(alumni), 'post' do
    end
  end
end
