require 'rails_helper'

RSpec.describe('alumnis/show') do
  before do
    user = FactoryBot.create(:user)
    assign(:alumni, user)
    sign_in user
  end

  it 'renders attributes in <p>' do
    render
  end
end
