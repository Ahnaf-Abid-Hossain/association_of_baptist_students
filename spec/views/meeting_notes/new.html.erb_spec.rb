require 'rails_helper'

RSpec.describe('meeting_notes/new') do
  before do
    assign(:meeting_note, FactoryBot.create(:meeting_note))
  end

  # it 'renders new meeting_note form' do
  #   render

  #   assert_select 'form[action=?][method=?]', meeting_notes_path, 'post' do
  #     assert_select 'input[name=?]', 'meeting_note[title]'

  #     assert_select 'textarea[name=?]', 'meeting_note[content]'

  #     assert_select 'input[name=?]', 'meeting_note[id]'
  #   end
  # end

  pending 'renders new meeting_note form'
end
