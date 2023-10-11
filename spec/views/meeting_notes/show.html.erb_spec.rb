require 'rails_helper'

RSpec.describe('meeting_notes/show') do
  before do
    assign(:meeting_note, FactoryBot.create(:meeting_note, title: 'Title', content: 'MyText'))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to(match(/Title/))
    expect(rendered).to(match(/MyText/))
    expect(rendered).to(match(//))
  end
end
