require 'rails_helper'
require 'capybara/rspec'

RSpec.describe('meeting_notes/index') do
  before do
    # Create an alumni to be the author of the notes
    # driven_by(:rack_test)
    author = FactoryBot.create(:user)
    sign_in author
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


  it 'displays a table with the expected structure' do
    render
    assert_select 'tr>td', text: Regexp.new('Title'.to_s), count: 2
    assert_select 'tr>td', text: Regexp.new('MyText'.to_s), count: 2
  end
  
end
