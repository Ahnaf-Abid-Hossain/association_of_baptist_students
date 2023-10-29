require 'rails_helper'

RSpec.describe('links/index') do
  before do
    # Create user for authorship
    admin_user = FactoryBot.create(:admin_user, user_first_name: "Johnny", user_last_name: "Admin")

    assign(:links, [
      FactoryBot.create(:link, user: admin_user, label: 'XLabel', url: 'XURL', order: 2),
      FactoryBot.create(:link, user: admin_user, label: 'XLabel', url: 'XURL', order: 3)
    ])
  end

  it 'renders a list of links' do
    render
    assert_select 'tr>td', text: Regexp.new('XLabel'.to_s), count: 2
    assert_select 'tr>td', text: Regexp.new('XURL'.to_s), count: 2
    assert_select 'tr>td a', text: Regexp.new('Johnny Admin'.to_s), count: 2
  end

  it 'has up/down buttons' do
    render
    assert_select '.up-down button.up-button', count: 2
    assert_select '.up-down button.down-button', count: 2
  end
end
