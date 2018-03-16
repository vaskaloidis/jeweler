require "rails_helper"

RSpec.describe InvoiceItemsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/invoice_items").to route_to("invoice_items#index")
    end

    it "routes to #new" do
      expect(:get => "/invoice_items/new").to route_to("invoice_items#new")
    end

    it "routes to #show" do
      expect(:get => "/invoice_items/1").to route_to("invoice_items#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/invoice_items/1/edit").to route_to("invoice_items#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/invoice_items").to route_to("invoice_items#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/invoice_items/1").to route_to("invoice_items#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/invoice_items/1").to route_to("invoice_items#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/invoice_items/1").to route_to("invoice_items#destroy", :id => "1")
    end

  end
end
