require 'rails_helper'

RSpec.describe('links/edit') do
  let(:link) do
    # Link.create!(
    #   label: 'MyString',
    #   url: 'MyString',
    #   order: 1
    # )
    FactoryBot.create(:link)
  end

  before do
    assign(:link, link)
  end

  it 'renders the edit link form' do
    render

    assert_select 'form[action=?][method=?]', link_path(link), 'post' do
      assert_select 'input[name=?]', 'link[label]'

      assert_select 'input[name=?]', 'link[url]'

      assert_select 'input[name=?]', 'link[order]'
    end
  end
end
