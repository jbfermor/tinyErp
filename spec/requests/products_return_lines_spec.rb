require 'rails_helper'

RSpec.describe "ProductsReturnLines", type: :request do
  describe "GET /create" do
    it "returns http success" do
      get "/products_return_lines/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/products_return_lines/update"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /delete" do
    it "returns http success" do
      get "/products_return_lines/delete"
      expect(response).to have_http_status(:success)
    end
  end

end
