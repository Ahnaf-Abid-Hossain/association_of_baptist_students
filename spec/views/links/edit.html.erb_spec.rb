require 'rails_helper'

RSpec.describe('links/edit') do
  let(:link) do
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
    end
  end
end
