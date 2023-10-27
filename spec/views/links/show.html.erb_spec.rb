require 'rails_helper'

RSpec.describe('links/show') do
  before do
    assign(:link, Link.create!(
                    label: 'Label',
                    url: 'Url',
                    order: 2,
                    user: FactoryBot.create(:admin_user, user_first_name: 'Show', user_last_name: 'Test')
                  )
    )
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to(match(/Label/))
    expect(rendered).to(match(/Url/))
    expect(rendered).to(match(/2/))
    expect(rendered).to(match(/Show Test/))
  end
end
