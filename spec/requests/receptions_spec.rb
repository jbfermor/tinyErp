require 'rails_helper'

RSpec.describe ReceptionsController, type: :controller do
  let(:user) { create(:user) }
  let(:supplier) { create(:supplier, user: user) }
  let(:buy) { create(:buy, user: user, supplier: supplier) }
  let(:valid_attributes) { { user_id: user.id, supplier_id: supplier.id, buy_id: buy.id, last_reception_date: Date.today, state: :created } }
  let(:invalid_attributes) { { user_id: nil, supplier_id: nil, buy_id: nil } }

  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'returns a success response' do
      reception = ReceptionCreationService.new(user, supplier.id, buy.id).call
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      reception = ReceptionCreationService.new(user, supplier.id, buy.id).call
      get :show, params: { id: reception.to_param }
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new
      expect(response).to be_successful
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      reception = ReceptionCreationService.new(user, supplier.id, buy.id).call
      get :edit, params: { id: reception.to_param }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Reception' do
        expect {
          post :create, params: { reception: valid_attributes }
        }.to change(Reception, :count).by(1)
      end

      it 'redirects to the created reception' do
        post :create, params: { reception: valid_attributes }
        expect(response).to redirect_to(Reception.last)
      end
    end

    context 'with invalid params' do
      it 'returns a success response (i.e. to display the "new" template)' do
        post :create, params: { reception: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid params' do
      let(:new_attributes) { { last_reception_date: Date.tomorrow } }

      it 'updates the requested reception' do
        reception = ReceptionCreationService.new(user, supplier.id, buy.id).call
        patch :update, params: { id: reception.to_param, reception: new_attributes }
        reception.reload
        expect(reception.last_reception_date).to eq(Date.tomorrow)
      end

      it 'redirects to the reception' do
        reception = ReceptionCreationService.new(user, supplier.id, buy.id).call
        patch :update, params: { id: reception.to_param, reception: valid_attributes }
        expect(response).to redirect_to(reception)
      end
    end

    context 'with invalid params' do
      it 'returns a success response (i.e. to display the "edit" template)' do
        reception = ReceptionCreationService.new(user, supplier.id, buy.id).call
        patch :update, params: { id: reception.to_param, reception: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested reception' do
      reception = ReceptionCreationService.new(user, supplier.id, buy.id).call
      expect {
        delete :destroy, params: { id: reception.to_param }
      }.to change(Reception, :count).by(-1)
    end

    it 'redirects to the receptions list' do
      reception = ReceptionCreationService.new(user, supplier.id, buy.id).call
      delete :destroy, params: { id: reception.to_param }
      expect(response).to redirect_to(receptions_url)
    end
  end

  describe 'PATCH #complete' do
    it 'marks all reception lines as fully received' do
      reception = ReceptionCreationService.new(user, supplier.id, buy.id).call
      patch :complete, params: { id: reception.to_param }
      reception.reload
      expect(reception.state).to eq('fully_received')
    end

    it 'redirects to the reception' do
      reception = ReceptionCreationService.new(user, supplier.id, buy.id).call
      patch :complete, params: { id: reception.to_param }
      expect(response).to redirect_to(reception)
    end
  end
end
