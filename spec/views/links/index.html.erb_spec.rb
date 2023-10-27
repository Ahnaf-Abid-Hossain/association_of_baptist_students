require 'rails_helper'

RSpec.describe('links/index') do
  before do
    assign(:links, [
      Link.create!(
        label: 'XLabel',
        url: 'XUrl',
        order: 2
      ),
      Link.create!(
        label: 'XLabel',
        url: 'XUrl',
        order: 3
      )
    ]
    )
  end

  it 'renders a list of links' do
    render
    cell_selector = 'tr>td'
    assert_select cell_selector, text: Regexp.new('XLabel'.to_s), count: 2
    assert_select cell_selector, text: Regexp.new('XUrl'.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 1
    assert_select cell_selector, text: Regexp.new(3.to_s), count: 1
  end
end
