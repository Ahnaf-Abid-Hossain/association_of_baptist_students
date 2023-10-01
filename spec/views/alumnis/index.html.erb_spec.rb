require 'rails_helper'

RSpec.describe('alumnis/index', type: :view) do
  before do
    user1 = User.create!(email: 'test1@gmail.com')
    user2 = User.create!(email: 'test2@gmail.com')
    assign(:alumnis, [
      Alumni.create!(user: user1),
      Alumni.create!(user: user2)
    ]
    )
  end

  it 'renders a list of alumnis' do
    render
    Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
  end
end
