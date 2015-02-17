require "rails_helper"

RSpec.describe PlaysController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/plays").to route_to("plays#index")
    end

    it "routes to #new" do
      expect(:get => "/plays/new").to route_to("plays#new")
    end

    it "routes to #show" do
      expect(:get => "/plays/1").to route_to("plays#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/plays/1/edit").to route_to("plays#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/plays").to route_to("plays#create")
    end

    it "routes to #update" do
      expect(:put => "/plays/1").to route_to("plays#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/plays/1").to route_to("plays#destroy", :id => "1")
    end

  end
end
