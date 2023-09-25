require "rails_helper"

RSpec.describe PrayerRequestsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/prayer_requests").to route_to("prayer_requests#index")
    end

    it "routes to #new" do
      expect(get: "/prayer_requests/new").to route_to("prayer_requests#new")
    end

    it "routes to #show" do
      expect(get: "/prayer_requests/1").to route_to("prayer_requests#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/prayer_requests/1/edit").to route_to("prayer_requests#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/prayer_requests").to route_to("prayer_requests#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/prayer_requests/1").to route_to("prayer_requests#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/prayer_requests/1").to route_to("prayer_requests#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/prayer_requests/1").to route_to("prayer_requests#destroy", id: "1")
    end
  end
end
