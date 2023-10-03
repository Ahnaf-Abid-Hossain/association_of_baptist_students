require 'rails_helper'

RSpec.describe('links/new') do
  before do
    assign(:link, Link.new(
                    label: 'MyString',
                    url: 'MyString',
                    order: 1
                  )
    )
  end

  it 'renders new link form' do
    render

    assert_select 'form[action=?][method=?]', links_path, 'post' do
      assert_select 'input[name=?]', 'link[label]'

      assert_select 'input[name=?]', 'link[url]'

      assert_select 'input[name=?]', 'link[order]'
    end
  end
end
