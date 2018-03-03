require "rails_helper"

RSpec.describe ProjectCustomersController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/project_customers").to route_to("project_customers#index")
    end

    it "routes to #new" do
      expect(:get => "/project_customers/new").to route_to("project_customers#new")
    end

    it "routes to #show" do
      expect(:get => "/project_customers/1").to route_to("project_customers#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/project_customers/1/edit").to route_to("project_customers#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/project_customers").to route_to("project_customers#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/project_customers/1").to route_to("project_customers#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/project_customers/1").to route_to("project_customers#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/project_customers/1").to route_to("project_customers#destroy", :id => "1")
    end

  end
end
