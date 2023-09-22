require 'rails_helper'

RSpec.describe "alumnis/index", type: :view do
  before(:each) do
    assign(:alumnis, [
      Alumni.create!(),
      Alumni.create!()
    ])
  end

  it "renders a list of alumnis" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
  end
end
