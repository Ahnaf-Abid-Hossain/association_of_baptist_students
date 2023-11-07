require 'rails_helper'

RSpec.describe('/meeting_notes') do
  let(:meeting_note) do
    FactoryBot.create(:meeting_note, title: 'MyString', content: 'MyText')
  end

  before do
    driven_by(:rack_test)
    @author = FactoryBot.create(:admin_user)
    # @meeting_note = FactoryBot.create(:meeting_note)
    @meeting_note = MeetingNote.create!(
      title: 'Title',
      content: 'MyText',
      date: '2023-11-06',
      user: @author # Replace with the desired date
    )
    @user = FactoryBot.create(:user)
  end

  it 'searches meeting notes by date' do
    sign_in @author
    # Visit the meeting notes index page
    visit meeting_notes_path
    # puts page.body
    # Fill in the search form with the desired date
    expect(page).to(have_content('Title'))
    expect(page).to(have_content('MyText'))
    expect(page).to(have_content('2023-11-06'))
    fill_in 'Enter Date', with: '2023-11-06' # Replace with the date you want to search for

    # Click the search button
    click_button 'Search'
    # visit basic_search_meeting_note_path
    # puts page.body
    # Verify that the search results include the meeting note with the specified date
    # table = find('table')
    expect(page).to(have_content('Title'))
    expect(page).to(have_content('MyText'))
    expect(page).to(have_content('2023-11-06'))

    # Verify that other meeting notes are not displayed
    MeetingNote.where.not(id: @meeting_note.id).find_each do |other_note|
      expect(page).not_to(have_content(other_note.title))
      expect(page).not_to(have_content(other_note.content))
      expect(page).not_to(have_content(other_note.date))
      # for lele
    end
  end

  it 'lets not admins see meeting notes' do
    sign_in @user
    # Visit the meeting notes index page
    visit meeting_notes_path
    # puts page.body
    # Fill in the search form with the desired date
    expect(page).to(have_content('Title'))
    expect(page).to(have_content('MyText'))
    expect(page).to(have_content('2023-11-06'))
  end

  it "non admins can't create meeting notes" do
    # Sign in with the non-admin user
    sign_in @user

    # Attempt to visit the meeting notes creation page
    visit new_meeting_note_path

    # Check that the user is redirected or denied access
    expect(page).to(have_content('You do not have permission to access this page'))
  end
end
