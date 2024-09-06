require "rails_helper"

RSpec.describe ProductsReturnsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/products_returns").to route_to("products_returns#index")
    end

    it "routes to #new" do
      expect(get: "/products_returns/new").to route_to("products_returns#new")
    end

    it "routes to #show" do
      expect(get: "/products_returns/1").to route_to("products_returns#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/products_returns/1/edit").to route_to("products_returns#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/products_returns").to route_to("products_returns#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/products_returns/1").to route_to("products_returns#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/products_returns/1").to route_to("products_returns#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/products_returns/1").to route_to("products_returns#destroy", id: "1")
    end
  end
end
