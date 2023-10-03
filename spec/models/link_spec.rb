require 'rails_helper'

RSpec.describe(Link) do
  it 'is valid when filled out' do
    link = described_class.new(url: 'test.com', label: 'Test', order: 0)
    expect(link).to(be_valid)
  end

  it 'is not valid with a negative order' do
    link = described_class.new(url: 'test.com', label: 'Test', order: -2)
    expect(link).not_to(be_valid)
  end

  it 'is not valid without a label' do
    link = described_class.new(url: 'test.com', order: -2)
    expect(link).not_to(be_valid)
  end

  it 'is not valid without an order' do
    link = described_class.new(url: 'test.com', label: 'Test')
    expect(link).not_to(be_valid)
  end

  it 'is not valid without a url' do
    link = described_class.new(label: 'Test', order: 2)
    expect(link).not_to(be_valid)
  end
end
