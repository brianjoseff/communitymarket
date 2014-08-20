require "spec_helper"

describe DressesController do
  describe "routing" do

    it "routes to #index" do
      get("/dresses").should route_to("dresses#index")
    end

    it "routes to #new" do
      get("/dresses/new").should route_to("dresses#new")
    end

    it "routes to #show" do
      get("/dresses/1").should route_to("dresses#show", :id => "1")
    end

    it "routes to #edit" do
      get("/dresses/1/edit").should route_to("dresses#edit", :id => "1")
    end

    it "routes to #create" do
      post("/dresses").should route_to("dresses#create")
    end

    it "routes to #update" do
      put("/dresses/1").should route_to("dresses#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/dresses/1").should route_to("dresses#destroy", :id => "1")
    end

  end
end
