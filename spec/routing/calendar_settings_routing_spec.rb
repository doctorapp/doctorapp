require "spec_helper"

describe CalendarSettingsController do
  describe "routing" do

    it "routes to #index" do
      get("/calendar_settings").should route_to("calendar_settings#index")
    end

    it "routes to #new" do
      get("/calendar_settings/new").should route_to("calendar_settings#new")
    end

    it "routes to #show" do
      get("/calendar_settings/1").should route_to("calendar_settings#show", :id => "1")
    end

    it "routes to #edit" do
      get("/calendar_settings/1/edit").should route_to("calendar_settings#edit", :id => "1")
    end

    it "routes to #create" do
      post("/calendar_settings").should route_to("calendar_settings#create")
    end

    it "routes to #update" do
      put("/calendar_settings/1").should route_to("calendar_settings#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/calendar_settings/1").should route_to("calendar_settings#destroy", :id => "1")
    end

  end
end
