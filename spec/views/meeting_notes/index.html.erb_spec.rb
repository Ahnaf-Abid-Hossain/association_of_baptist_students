require 'rails_helper'

RSpec.describe('meeting_notes/index') do
  before do
    # Create an alumni to be the author of the notes
    author = FactoryBot.create(:user)

    assign(:meeting_notes, [
      MeetingNote.create!(
        title: 'Title',
        content: 'MyText',
        user: author
      ),
      MeetingNote.create!(
        title: 'Title',
        content: 'MyText',
        user: author
      )
    ]
    )
  end

  it 'renders a list of meeting_notes' do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new('Title'.to_s), count: 2
    assert_select cell_selector, text: Regexp.new('MyText'.to_s), count: 2
    # assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
  end
end
