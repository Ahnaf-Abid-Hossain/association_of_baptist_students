require 'rails_helper'

RSpec.describe "meeting_notes/show", type: :view do
  before(:each) do
    assign(:meeting_note, MeetingNote.create!(
      title: "Title",
      content: "MyText",
      alumni: nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(//)
  end
end
