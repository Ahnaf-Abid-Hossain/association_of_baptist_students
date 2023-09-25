=begin
require 'rails_helper'

RSpec.describe PrayerRequest, type: :model do
  describe 'validations' do
    it 'requires the request to be present' do
      prayer_request = PrayerRequest.new(status: 'pending')
      expect(prayer_request).not_to be_valid
    end

    it 'requires the status to be present' do
      prayer_request = PrayerRequest.new(request: 'Please pray for me.')
      expect(prayer_request).not_to be_valid
    end
  end

  describe 'associations' do
    it 'belongs to an alumni' do
      association = described_class.reflect_on_association(:alumni)
      expect(association.macro).to eq(:belongs_to)
    end
  end


  describe 'factory' do
    it 'is valid' do
      # Using FactoryBot to create a prayer request
      prayer_request = FactoryBot.build(:prayer_request)

      # Check if the prayer request is valid
      expect(prayer_request).to be_valid
    end
  end

  describe '#admin_can_edit?' do
    let(:prayer_request) { FactoryBot.build(:prayer_request) }
    
    context 'when user is an admin' do
      it 'returns true' do
        allow(prayer_request).to receive_message_chain(:alumni, :user, :is_admin?).and_return(true)
        expect(prayer_request.admin_can_edit?).to be true
      end
    end

    context 'when user is not an admin' do
      it 'returns false' do
        allow(prayer_request).to receive_message_chain(:alumni, :user, :is_admin?).and_return(false)
        expect(prayer_request.admin_can_edit?).to be false
      end
    end
  end
end
=end