require 'rails_helper'

RSpec.describe User, type: :model do
  it 'should allow gmail accounts to log in' do
    user = User.from_google(email: 'test@gmail.com', uid: '00000', full_name: 'Test User', avatar_url: '/')
    expect(user).to_not eq(nil)
  end

  it 'should disallow tamu accounts from logging in' do
    user = User.from_google(email: 'test@tamu.edu', uid: '00000', full_name: 'Test User', avatar_url: '/')
    expect(user).to eq(nil)
  end
end
