require 'rails_helper'

RSpec.describe SellsController, type: :controller do
  let(:user) { create(:user) }
  let(:customer) { create(:customer, user: user) }
  let(:valid_attributes) {
    { customer_id: customer.id, sell_date: Date.today, total_sell: 100.0, user: user }
  }

  before { sign_in user }

  describe "GET #index" do
    it "returns a success response" do
      Sell.create! valid_attributes
      get :index
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      sell = Sell.create! valid_attributes
      get :show, params: { id: sell.to_param }
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Sell" do
        expect {
          post :create, params: { sell: valid_attributes }
        }.to change(Sell, :count).by(1)
      end

      it "redirects to the created sell" do
        post :create, params: { sell: valid_attributes }
        expect(response).to redirect_to(Sell.last)
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        { total_sell: 200.0 }
      }

      it "updates the requested sell" do
        sell = Sell.create! valid_attributes
        put :update, params: { id: sell.to_param, sell: new_attributes }
        sell.reload
        expect(sell.total_sell).to eq(200.0)
      end

      it "redirects to the sell" do
        sell = Sell.create! valid_attributes
        put :update, params: { id: sell.to_param, sell: new_attributes }
        expect(response).to redirect_to(sell)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested sell" do
      sell = Sell.create! valid_attributes
      expect {
        delete :destroy, params: { id: sell.to_param }
      }.to change(Sell, :count).by(-1)
    end

    it "redirects to the sells list" do
      sell = Sell.create! valid_attributes
      delete :destroy, params: { id: sell.to_param }
      expect(response).to redirect_to(sells_url)
    end
  end
end
