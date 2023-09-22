require 'rails_helper'

RSpec.describe "alumnis/edit", type: :view do
  let(:alumni) {
    Alumni.create!()
  }

  before(:each) do
    assign(:alumni, alumni)
  end

  it "renders the edit alumni form" do
    render

    assert_select "form[action=?][method=?]", alumni_path(alumni), "post" do
    end
  end
end
