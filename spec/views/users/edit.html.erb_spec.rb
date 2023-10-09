require 'rails_helper'

RSpec.describe('users/edit') do
  let(:user) do
    FactoryBot.create(:user)
  end

  before do
    assign(:user, user)
    sign_in user
  end

  it 'renders the edit user form' do
    render

    assert_select 'form[action=?][method=?]', user_path(user), 'post' do
    end
  end
end
