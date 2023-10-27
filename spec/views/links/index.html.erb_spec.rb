require 'rails_helper'

RSpec.describe('links/index') do
  before do
    # Create user for authorship
    admin_user = FactoryBot.create(:admin_user)

    assign(:links, [
      FactoryBot.create(:link, user: admin_user, label: 'XLabel', url: 'XURL', order: 2),
      FactoryBot.create(:link, user: admin_user, label: 'XLabel', url: 'XURL', order: 3)
    ]
    )
  end

  it 'renders a list of links' do
    render
    cell_selector = 'tr>td'
    assert_select cell_selector, text: Regexp.new('XLabel'.to_s), count: 2
    assert_select cell_selector, text: Regexp.new('XURL'.to_s), count: 2
  end
end
