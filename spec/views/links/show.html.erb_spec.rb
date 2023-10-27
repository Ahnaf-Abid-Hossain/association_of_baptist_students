require 'rails_helper'

RSpec.describe('links/show') do
  before do
    admin_user = FactoryBot.create(:admin_user, user_first_name: 'Show', user_last_name: 'Test')
    assign(:link, FactoryBot.create(:link,
      label: 'Label',
      url: 'Url',
      user: admin_user
    ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to(match(/Label/))
    expect(rendered).to(match(/Url/))
    expect(rendered).to(match(/Show Test/))
  end
end
