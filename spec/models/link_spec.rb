require 'rails_helper'

RSpec.describe(Link) do
  it 'is valid when filled out' do
    user = FactoryBot.create(:admin_user)
    link = described_class.new(url: 'test.com', label: 'Test', order: 0, user: user)
    expect(link).to(be_valid)
  end

  it 'is not valid with a negative order' do
    user = FactoryBot.create(:admin_user)
    link = described_class.new(url: 'test.com', label: 'Test', order: -2, user: user)
    expect(link).not_to(be_valid)
  end

  it 'is not valid without a label' do
    user = FactoryBot.create(:admin_user)
    link = described_class.new(url: 'test.com', order: -2, user: user)
    expect(link).not_to(be_valid)
  end

  it 'is not valid without an order' do
    user = FactoryBot.create(:admin_user)
    link = described_class.new(url: 'test.com', label: 'Test', user: user)
    expect(link).not_to(be_valid)
  end

  it 'is not valid without a url' do
    user = FactoryBot.create(:admin_user)
    link = described_class.new(label: 'Test', order: 2, user: user)
    expect(link).not_to(be_valid)
  end

  it 'is not valid without a user' do
    link = described_class.new(url: 'test.com', label: 'Test', order: 2)
    expect(link).not_to(be_valid)
  end
end
