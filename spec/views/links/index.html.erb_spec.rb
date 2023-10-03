require 'rails_helper'

RSpec.describe('links/index') do
  before do
    assign(:links, [
      Link.create!(
        label: 'Label',
        url: 'Url',
        order: 2
      ),
      Link.create!(
        label: 'Label',
        url: 'Url',
        order: 2
      )
    ]
    )
  end

  it 'renders a list of links' do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new('Label'.to_s), count: 2
    assert_select cell_selector, text: Regexp.new('Url'.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
  end
end
