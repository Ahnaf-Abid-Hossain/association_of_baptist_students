require 'rails_helper'

RSpec.describe "users/show", type: :view do
  before(:each) do
    user = FactoryBot.create(:user)
    sign_in user
    
    @user = user
    @meeting_notes = [
      FactoryBot.create(:meeting_note, user: user)
    ]
  end

  it 'renders attributes in <p>' do
    render
  end
end
