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

  it 'properly returns next order' do
    # Delete all
    described_class.destroy_all
    expect(described_class.count).to(eq(0))

    # Create user to author links
    user = FactoryBot.create(:admin_user)
    expect(user).not_to(be_nil)

    # Ensure Link.get_next_order returns 1 when no links exist
    expect(described_class.get_next_order).to(eq(1))

    # Create a link
    link = FactoryBot.create(:link, user: user, order: 1)
    expect(link).not_to(be_nil)

    # Link.get_next_order should return 2 now
    expect(described_class.get_next_order).to(eq(2))

    # Create a second link
    link2 = FactoryBot.create(:link, user: user, order: 2)
    expect(link2).not_to(be_nil)

    # Link.get_next_order should return 3 now
    expect(described_class.get_next_order).to(eq(3))

    # Delete the first link
    link.destroy!

    # Now call reorder_links
    described_class.reorder_links

    # Now Link.get_next_order should return 2 again
    expect(described_class.get_next_order).to(eq(2))
  end
end
