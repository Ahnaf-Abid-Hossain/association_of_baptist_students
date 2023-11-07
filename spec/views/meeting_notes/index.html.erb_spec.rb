require 'rails_helper'
require 'capybara/rspec'

RSpec.describe('meeting_notes/index') do
  before do
    # Create an alumni to be the author of the notes
    driven_by(:rack_test)
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

  # it 'renders a list of meeting_notes' do
  #   render
  #   cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
  #   assert_select cell_selector, text: Regexp.new('Title'.to_s), count: 2
  #   assert_select cell_selector, text: Regexp.new('MyText'.to_s), count: 2
  #   # assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
  # end

  it 'displays a table with the expected structure' do
    # Assuming you have a way to create or fetch @meeting_notes in your test database
    # This may vary depending on your application's structure and testing setup
    # user = FactoryBot.create(:user)
    # sign_in author
    visit '/meeting_notes'  # Update the URL to match your route

    expect(page).to have_selector('table#links')
    expect(page).to have_selector('table#links thead')
    expect(page).to have_selector('table#links thead tr th', count: 3)
    expect(page).to have_selector('table#links tbody')
    expect(page).to have_selector('table#links tbody tr', count: @meeting_notes.length)

    @meeting_notes.each do |meeting_note|
      expect(page).to have_selector('table#links tbody tr td', text: meeting_note.title)
      expect(page).to have_selector('table#links tbody tr td', text: meeting_note.content)
      expect(page).to have_selector('table#links tbody tr td', text: meeting_note.date)
    end
  end
  
end
