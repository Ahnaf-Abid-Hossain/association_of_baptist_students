require 'rails_helper'

RSpec.describe "links/edit", type: :view do
  let(:link) {
    Link.create!(
      label: "MyString",
      url: "MyString",
      order: 1
    )
  }

  before(:each) do
    assign(:link, link)
  end

  it "renders the edit link form" do
    render

    assert_select "form[action=?][method=?]", link_path(link), "post" do

      assert_select "input[name=?]", "link[label]"

      assert_select "input[name=?]", "link[url]"

      assert_select "input[name=?]", "link[order]"
    end
  end
end
