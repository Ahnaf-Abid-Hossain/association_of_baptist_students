require 'rails_helper'

RSpec.describe('links/index') do
  before do
    # Create user for authorship
    admin_user = FactoryBot.create(:admin_user)

    assign(:links, [
      FactoryBot.create(:link, user: admin_user, order: 2),
      FactoryBot.create(:link, user: admin_user, order: 3)
    ]
    )
  end

  it 'renders a list of links' do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new('Label'.to_s), count: 2
    assert_select cell_selector, text: Regexp.new('Url'.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 1
    assert_select cell_selector, text: Regexp.new(3.to_s), count: 1
  end
end
