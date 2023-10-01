require 'rails_helper'

RSpec.describe('alumnis/show') do
  before do
    user = User.create!(email: 'test@gmail.com')
    assign(:alumni, Alumni.create!(user: user))
  end

  it 'renders attributes in <p>' do
    render
  end
end
