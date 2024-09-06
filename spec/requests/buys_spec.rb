require 'rails_helper'

RSpec.describe BuysController, type: :controller do
  let(:user) { create(:user) }
  let(:supplier) { create(:supplier, user: user) }
  let(:buy) { create(:buy, user: user, supplier: supplier) }

  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      get :show, params: { id: buy.id }
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      let(:valid_attributes) {
        { buy_date: Date.today, supplier_id: supplier.id }
      }

      it 'creates a new Buy' do
        expect {
          post :create, params: { buy: valid_attributes }
        }.to change(Buy, :count).by(1)
      end

      it 'redirects to the created buy' do
        post :create, params: { buy: valid_attributes }
        expect(response).to redirect_to(Buy.last)
      end
    end

    context 'with invalid params' do
      let(:invalid_attributes) {
        { buy_date: '', supplier_id: nil }
      }

      it 'returns a success response (i.e. to display the "new" template)' do
        post :create, params: { buy: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      get :edit, params: { id: buy.id }
      expect(response).to be_successful
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) {
        { buy_date: Date.tomorrow }
      }

      it 'updates the requested buy' do
        put :update, params: { id: buy.id, buy: new_attributes }
        buy.reload
        expect(buy.buy_date).to eq(Date.tomorrow)
      end

      it 'redirects to the buy' do
        put :update, params: { id: buy.id, buy: new_attributes }
        expect(response).to redirect_to(buy)
      end
    end

    context 'with invalid params' do
      let(:invalid_attributes) {
        { buy_date: '' }
      }

      it 'returns a success response (i.e. to display the "edit" template)' do
        put :update, params: { id: buy.id, buy: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested buy' do
      buy = create(:buy, user: user, supplier: supplier)
      expect {
        delete :destroy, params: { id: buy.id }
      }.to change(Buy, :count).by(-1)
    end

    it 'redirects to the buys list' do
      delete :destroy, params: { id: buy.id }
      expect(response).to redirect_to(buys_url)
    end
  end

  describe 'PATCH #confirm' do
    it 'confirms the requested buy' do
      patch :confirm, params: { id: buy.id }
      buy.reload
      expect(buy.status).to eq('pedido')
    end

    it 'redirects to the buy' do
      patch :confirm, params: { id: buy.id }
      expect(response).to redirect_to(buy)
    end
  end
end
