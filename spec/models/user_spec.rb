require 'rails_helper'

RSpec.describe(User) do
  it 'allows gmail accounts to log in' do
    user = described_class.from_google(email: 'test@gmail.com', uid: '00000', full_name: 'Test User', avatar_url: '/')
    expect(user).not_to(be_nil)
  end

  it 'disallows tamu accounts from logging in' do
    user = described_class.from_google(email: 'test@tamu.edu', uid: '00000', full_name: 'Test User', avatar_url: '/')
    expect(user).to(be_nil)
  end

  # TODO: validate fields
end
