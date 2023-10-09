require 'rails_helper'

RSpec.describe "Approvals", type: :request do
  before do
    sign_in FactoryBot.create(:admin_user)
  end

  describe "GET /index" do
    it "returns http success" do
      get "/approvals/index"
      expect(response).to have_http_status(:success)
    end
  end
end
