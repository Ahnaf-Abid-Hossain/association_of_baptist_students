require 'rails_helper'

RSpec.describe "Approvals", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/approvals/index"
      expect(response).to have_http_status(:success)
    end
  end

end
