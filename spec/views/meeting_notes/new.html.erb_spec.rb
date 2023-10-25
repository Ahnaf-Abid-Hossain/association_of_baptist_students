require 'rails_helper'

RSpec.describe('meeting_notes/new') do
  before do
    @admin = FactoryBot.create(:admin_user, email: 'admin@gmail.com')
  end
  # before do
  #   assign(:meeting_note, FactoryBot.create(:meeting_note))
  # end

  it 'renders new meeting_note form' do
    sign_in @admin
    meeting_note = MeetingNote.new
    assign(:meeting_note, meeting_note)
    render

    assert_select 'form[action=?][method=?]', meeting_notes_path, 'post' do
      assert_select 'input[name=?]', 'meeting_note[title]'

      assert_select 'textarea[name=?]', 'meeting_note[content]'
    end
  end
end
