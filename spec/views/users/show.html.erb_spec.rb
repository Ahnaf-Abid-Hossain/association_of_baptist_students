require 'rails_helper'

RSpec.describe('users/show') do
  before do
    user = FactoryBot.create(:user)
    sign_in user

    @user = user
    @meeting_notes = FactoryBot.create_list(:meeting_note, 1, user: user)
  end

  it 'renders attributes in <p>' do
    render
  end
end
