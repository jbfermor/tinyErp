require 'rails_helper'

RSpec.describe SellLinesController, type: :controller do
  let(:user) { create(:user) }
  let(:sell) { create(:sell, user: user) }
  let(:product) { create(:product) }
  let(:valid_attributes) {
    { product_id: product.id, product_quantity: 10, total_sell_line: product.sell_price * 10, sell_id: sell.id }
  }

  before { sign_in user }

  describe "POST #create" do
    context "with valid params" do
      it "creates a new SellLine" do
        expect {
          post :create, params: { sell_id: sell.id, sell_line: valid_attributes }
        }.to change(SellLine, :count).by(1)
      end

      it "redirects to the sell" do
        post :create, params: { sell_id: sell.id, sell_line: valid_attributes }
        expect(response).to redirect_to(sell)
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        { product_quantity: 20, total_sell_line: product.sell_price * 20 }
      }

      it "updates the requested sell line" do
        sell_line = SellLine.create! valid_attributes
        put :update, params: { sell_id: sell.id, id: sell_line.to_param, sell_line: new_attributes }
        sell_line.reload
        expect(sell_line.product_quantity).to eq(20)
      end

      it "redirects to the sell" do
        sell_line = SellLine.create! valid_attributes
        put :update, params: { sell_id: sell.id, id: sell_line.to_param, sell_line: new_attributes }
        expect(response).to redirect_to(sell)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested sell line" do
      sell_line = SellLine.create! valid_attributes
      expect {
        delete :destroy, params: { sell_id: sell.id, id: sell_line.to_param }
      }.to change(SellLine, :count).by(-1)
    end

    it "redirects to the sell" do
      sell_line = SellLine.create! valid_attributes
      delete :destroy, params: { sell_id: sell.id, id: sell_line.to_param }
      expect(response).to redirect_to(sell)
    end
  end
end
