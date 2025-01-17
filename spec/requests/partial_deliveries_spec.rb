require 'rails_helper'

RSpec.describe "PartialDeliveries", type: :request do
  describe "GET /create" do
    it "returns http success" do
      get "/partial_deliveries/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /delete" do
    it "returns http success" do
      get "/partial_deliveries/delete"
      expect(response).to have_http_status(:success)
    end
  end

end
