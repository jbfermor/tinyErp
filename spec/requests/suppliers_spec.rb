require 'rails_helper'

RSpec.describe SuppliersController, type: :controller do
  let(:user) { create(:user) }
  let(:supplier) { create(:supplier, user: user) }

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
      get :show, params: { id: supplier.id }
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
        { nif: '12345678A', commercial_name: 'SupplierName', contact_person: 'John Doe', address: 'Address', city: 'City', postal_code: '12345', province: 'Province' }
      }

      it 'creates a new Supplier' do
        expect {
          post :create, params: { supplier: valid_attributes }
        }.to change(Supplier, :count).by(1)
      end

      it 'redirects to the created supplier' do
        post :create, params: { supplier: valid_attributes }
        expect(response).to redirect_to(Supplier.last)
      end
    end

    context 'with invalid params' do
      let(:invalid_attributes) {
        { nif: '', commercial_name: '', contact_person: '' }
      }

      it 'returns a success response (i.e. to display the "new" template)' do
        post :create, params: { supplier: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      get :edit, params: { id: supplier.id }
      expect(response).to be_successful
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) {
        { nif: '87654321B', commercial_name: 'NewSupplierName', contact_person: 'Jane Doe' }
      }

      it 'updates the requested supplier' do
        put :update, params: { id: supplier.id, supplier: new_attributes }
        supplier.reload
        expect(supplier.nif).to eq('87654321B')
      end

      it 'redirects to the supplier' do
        put :update, params: { id: supplier.id, supplier: new_attributes }
        expect(response).to redirect_to(supplier)
      end
    end

    context 'with invalid params' do
      let(:invalid_attributes) {
        { nif: '', commercial_name: '', contact_person: '' }
      }

      it 'returns a success response (i.e. to display the "edit" template)' do
        put :update, params: { id: supplier.id, supplier: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested supplier' do
      supplier = create(:supplier, user: user)
      expect {
        delete :destroy, params: { id: supplier.id }
      }.to change(Supplier, :count).by(-1)
    end

    it 'redirects to the suppliers list' do
      delete :destroy, params: { id: supplier.id }
      expect(response).to redirect_to(suppliers_url)
    end
  end
end
