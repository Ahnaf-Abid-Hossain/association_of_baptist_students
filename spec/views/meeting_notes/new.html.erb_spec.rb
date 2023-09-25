require 'rails_helper'

RSpec.describe "meeting_notes/new", type: :view do
  before(:each) do
    assign(:meeting_note, MeetingNote.new(
      title: "MyString",
      content: "MyText",
      alumni: nil
    ))
  end

  it "renders new meeting_note form" do
    render

    assert_select "form[action=?][method=?]", meeting_notes_path, "post" do

      assert_select "input[name=?]", "meeting_note[title]"

      assert_select "textarea[name=?]", "meeting_note[content]"

      assert_select "input[name=?]", "meeting_note[alumni_id]"
    end
  end
end
