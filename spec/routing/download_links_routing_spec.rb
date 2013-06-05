require "spec_helper"

describe DownloadLinksController do
  describe "routing" do

    it "routes to #index" do
      get("/download_links").should route_to("download_links#index")
    end

    it "routes to #new" do
      get("/download_links/new").should route_to("download_links#new")
    end

    it "routes to #show" do
      get("/download_links/1").should route_to("download_links#show", :id => "1")
    end

    it "routes to #edit" do
      get("/download_links/1/edit").should route_to("download_links#edit", :id => "1")
    end

    it "routes to #create" do
      post("/download_links").should route_to("download_links#create")
    end

    it "routes to #update" do
      put("/download_links/1").should route_to("download_links#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/download_links/1").should route_to("download_links#destroy", :id => "1")
    end

  end
end
