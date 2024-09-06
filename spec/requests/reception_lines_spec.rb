require 'rails_helper'

RSpec.describe ReceptionLinesController, type: :controller do
  let(:user) { create(:user) }
  let(:supplier) { create(:supplier, user: user) }
  let(:buy) { create(:buy, user: user, supplier: supplier) }
  let(:reception) { ReceptionCreationService.new(user, supplier.id, buy.id).call }
  let(:buy_line) { create(:buy_line, buy: buy) }
  let(:valid_attributes) { { reception_id: reception.id, buy_id: buy.id, buy_line_id: buy_line.id, quantity_to_receive: buy_line.product_quantity, quantity_received: 0, state: :created } }
  let(:invalid_attributes) { { reception_id: nil, buy_id: nil, buy_line_id: nil } }

  before do
    sign_in user
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new, params: { reception_id: reception.id }
      expect(response).to be_successful
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      reception_line = reception.reception_lines.create! valid_attributes
      get :edit, params: { id: reception_line.to_param }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new ReceptionLine' do
        expect {
          post :create, params: { reception_id: reception.id, reception_line: valid_attributes }
        }.to change(ReceptionLine, :count).by(1)
      end

      it 'redirects to the reception' do
        post :create, params: { reception_id: reception.id, reception_line: valid_attributes }
        expect(response).to redirect_to(reception)
      end
    end

    context 'with invalid params' do
      it 'returns a success response (i.e. to display the "new" template)' do
        post :create, params: { reception_id: reception.id, reception_line: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid params' do
      let(:new_attributes) { { quantity_received: 5 } }

      it 'updates the requested reception line' do
        reception_line = reception.reception_lines.create! valid_attributes
        patch :update, params: { id: reception_line.to_param, reception_line: new_attributes }
        reception_line.reload
        expect(reception_line.quantity_received).to eq(5)
      end

      it 'redirects to the reception' do
        reception_line = reception.reception_lines.create! valid_attributes
        patch :update, params: { id: reception_line.to_param, reception_line: valid_attributes }
        expect(response).to redirect_to(reception_line.reception)
      end
    end

    context 'with invalid params' do
      it 'returns a success response (i.e. to display the "edit" template)' do
        reception_line = reception.reception_lines.create! valid_attributes
        patch :update, params: { id: reception_line.to_param, reception_line: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested reception line' do
      reception_line = reception.reception_lines.create! valid_attributes
      expect {
        delete :destroy, params: { id: reception_line.to_param }
      }.to change(ReceptionLine, :count).by(-1)
    end

    it 'redirects to the reception' do
      reception_line = reception.reception_lines.create! valid_attributes
      delete :destroy, params: { id: reception_line.to_param }
      expect(response).to redirect_to(reception_line.reception)
    end
  end
end
