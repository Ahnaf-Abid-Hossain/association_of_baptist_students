require 'rails_helper'

RSpec.describe('meeting_notes/edit') do
  let(:meeting_note) do
    FactoryBot.create(:meeting_note, title: 'MyString', content: 'MyText')
  end

  before do
    assign(:meeting_note, meeting_note)
  end

  it 'renders the edit meeting_note form' do
    render

    assert_select 'form[action=?][method=?]', meeting_note_path(meeting_note), 'post' do
      assert_select 'input[name=?]', 'meeting_note[title]'

      assert_select 'textarea[name=?]', 'meeting_note[content]'

      assert_select 'input[name=?]', 'meeting_note[alumni_id]'
    end
  end
end
