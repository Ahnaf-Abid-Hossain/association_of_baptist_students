require 'rails_helper'

RSpec.describe('alumnis/index') do
  before do
    user1 = FactoryBot.create(:user)
    user2 = FactoryBot.create(:user)
    assign(:alumnis, [user1, user2])
    sign_in user1
  end

  it 'renders a list of alumnis' do
    render
    Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
  end
end
