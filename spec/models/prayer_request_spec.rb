require 'rails_helper'

RSpec.describe(PrayerRequest) do
  describe 'validations' do
    it 'requires the request to be present' do
      prayer_request = FactoryBot.build(:invalid_prayer_request_no_request)
      expect(prayer_request).not_to(be_valid)
    end

    it 'requires the status to be present' do
      prayer_request = FactoryBot.build(:invalid_prayer_request_no_status)
      expect(prayer_request).not_to(be_valid)
    end
  end

  describe 'associations' do
    it 'belongs to a user' do
      association = described_class.reflect_on_association(:user)
      expect(association.macro).to(eq(:belongs_to))
    end
  end

  describe 'factory' do
    context 'creating valid factory prayer requests' do
      it 'is valid' do
        prayer_request = FactoryBot.create(:prayer_request)

        expect(prayer_request).to(be_valid)
        prayer_request.destroy!
      end
    end

    context 'creating invalid factory prayer requests' do
      it 'is not valid' do
        prayer_request_no_request = FactoryBot.build(:invalid_prayer_request_no_request)
        prayer_request_no_status = FactoryBot.build(:invalid_prayer_request_no_status)

        expect(prayer_request_no_request).not_to(be_valid)
        expect(prayer_request_no_status).not_to(be_valid)
      end
    end
  end
end
