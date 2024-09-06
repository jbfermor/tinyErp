require 'rails_helper'

RSpec.describe CustomersController, type: :controller do
  let(:user) { create(:user) }
  let(:valid_attributes) { { user_id: user.id, nif: '12345678A', name: 'John', surname1: 'Doe', surname2: 'Smith', phone: '123456789', address: '123 Street', city: 'City', postal_code: '12345', province: 'Province' } }
  let(:invalid_attributes) { { user_id: user.id, nif: nil, name: nil, surname1: nil, phone: nil } }

  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'returns a success response' do
      Customer.create! valid_attributes
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      customer = Customer.create! valid_attributes
      get :show, params: { id: customer.to_param }
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
      customer = Customer.create! valid_attributes
      get :edit, params: { id: customer.to_param }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Customer' do
        expect {
          post :create, params: { customer: valid_attributes }
        }.to change(Customer, :count).by(1)
      end

      it 'redirects to the created customer' do
        post :create, params: { customer: valid_attributes }
        expect(response).to redirect_to(Customer.last)
      end
    end

    context 'with invalid params' do
      it 'returns a success response (i.e. to display the "new" template)' do
        post :create, params: { customer: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) { { phone: '987654321' } }

      it 'updates the requested customer' do
        customer = Customer.create! valid_attributes
        put :update, params: { id: customer.to_param, customer: new_attributes }
        customer.reload
        expect(customer.phone).to eq('987654321')
      end

      it 'redirects to the customer' do
        customer = Customer.create! valid_attributes
        put :update, params: { id: customer.to_param, customer: valid_attributes }
        expect(response).to redirect_to(customer)
      end
    end

    context 'with invalid params' do
      it 'returns a success response (i.e. to display the "edit" template)' do
        customer = Customer.create! valid_attributes
        put :update, params: { id: customer.to_param, customer: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested customer' do
      customer = Customer.create! valid_attributes
      expect {
        delete :destroy, params: { id: customer.to_param }
      }.to change(Customer, :count).by(-1)
    end

    it 'redirects to the customers list' do
      customer = Customer.create! valid_attributes
      delete :destroy, params: { id: customer.to_param }
      expect(response).to redirect_to(customers_url)
    end
  end
end
