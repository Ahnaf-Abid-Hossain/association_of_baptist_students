require 'rails_helper'

RSpec.describe "users/show", type: :view do
  before(:each) do
    #user = User.create!(email: "test@gmail.com")
    #assign(:user, user.create!(user: user))
    user = FactoryBot.create(:user)
    
    user_profile = user.new(
      user_first_name: "Test", 
      user_last_name: "User",
      user_email: "test@gmail.com",
      user_ph_num: "(555) 555-5555",
      user_class_year: 2024,
      user_job_field: "Software Engineering",
      user_location: "Houston, TX",
      user_status: "Current Student",
      user_major: "Computer Science")

    user_profile.user = user

    user_profile.save

    sign_in user

    @user = user_profile
   
    
    meeting_note_test = MeetingNote.create!(
      title: "Title",
      content: "MyText",
      user: user_profile)
  
    @meeting_notes = meeting_note_test
  end

  it 'renders attributes in <p>' do
    render
  end
end
