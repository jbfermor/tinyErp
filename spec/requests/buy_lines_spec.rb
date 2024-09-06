require 'rails_helper'

RSpec.describe BuyLinesController, type: :controller do
  let(:user) { create(:user) }
  let(:supplier) { create(:supplier, user: user) }
  let(:buy) { create(:buy, user: user, supplier: supplier) }
  let(:product) { create(:product, user: user, supplier: supplier) }
  let(:buy_line) { create(:buy_line, buy: buy, product: product) }

  before do
    sign_in user
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new, params: { buy_id: buy.id }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      let(:valid_attributes) {
        { buy_date: Date.today, product_quantity: 5, product_id: product.id }
      }

      it 'creates a new BuyLine' do
        expect {
          post :create, params: { buy_id: buy.id, buy_line: valid_attributes }
        }.to change(BuyLine, :count).by(1)
      end

      it 'redirects to the buy' do
        post :create, params: { buy_id: buy.id, buy_line: valid_attributes }
        expect(response).to redirect_to(buy)
      end
    end

    context 'with invalid params' do
      let(:invalid_attributes) {
        { buy_date: '', product_quantity: nil, product_id: nil }
      }

      it 'returns a success response (i.e. to display the "new" template)' do
        post :create, params: { buy_id: buy.id, buy_line: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      get :edit, params: { buy_id: buy.id, id: buy_line.id }
      expect(response).to be_successful
    end
  end

  describe 'PATCH #update' do
    context 'with valid params' do
      let(:new_attributes) {
        { buy_date: Date.today, product_quantity: 10, product_id: product.id }
      }

      it 'updates the requested buy line' do
        patch :update, params: { buy_id: buy.id, id: buy_line.id, buy_line: new_attributes }
        buy_line.reload
        expect(buy_line.product_quantity).to eq(10)
      end

      it 'redirects to the buy' do
        patch :update, params: { buy_id: buy.id, id: buy_line.id, buy_line: new_attributes }
        expect(response).to redirect_to(buy)
      end
    end

    context 'with invalid params' do
      let(:invalid_attributes) {
        { buy_date: '', product_quantity: nil, product_id: nil }
      }

      it 'returns a success response (i.e. to display the "edit" template)' do
        patch :update, params: { buy_id: buy.id, id: buy_line.id, buy_line: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested buy line' do
      buy_line
      expect {
        delete :destroy, params: { buy_id: buy.id, id: buy_line.id }
      }.to change(BuyLine, :count).by(-1)
    end

    it 'redirects to the buy' do
      delete :destroy, params: { buy_id: buy.id, id: buy_line.id }
      expect(response).to redirect_to(buy)
    end
  end
end
