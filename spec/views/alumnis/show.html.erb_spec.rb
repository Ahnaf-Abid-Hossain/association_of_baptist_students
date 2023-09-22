require 'rails_helper'

RSpec.describe "alumnis/show", type: :view do
  before(:each) do
    assign(:alumni, Alumni.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
