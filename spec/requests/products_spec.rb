require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  let(:user) { create(:user) }
  let(:supplier) { create(:supplier, user: user) }
  let(:product) { create(:product, user: user, supplier: supplier) }

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
      get :show, params: { id: product.id }
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
        { product_name: 'ProductName', product_description: 'ProductDescription', supplier_id: supplier.id }
      }

      it 'creates a new Product' do
        expect {
          post :create, params: { product: valid_attributes }
        }.to change(Product, :count).by(1)
      end

      it 'redirects to the created product' do
        post :create, params: { product: valid_attributes }
        expect(response).to redirect_to(Product.last)
      end
    end

    context 'with invalid params' do
      let(:invalid_attributes) {
        { product_name: '', product_description: '', supplier_id: nil }
      }

      it 'returns a success response (i.e. to display the "new" template)' do
        post :create, params: { product: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      get :edit, params: { id: product.id }
      expect(response).to be_successful
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) {
        { product_name: 'NewProductName', product_description: 'NewProductDescription' }
      }

      it 'updates the requested product' do
        put :update, params: { id: product.id, product: new_attributes }
        product.reload
        expect(product.product_name).to eq('NewProductName')
      end

      it 'redirects to the product' do
        put :update, params: { id: product.id, product: new_attributes }
        expect(response).to redirect_to(product)
      end
    end

    context 'with invalid params' do
      let(:invalid_attributes) {
        { product_name: '', product_description: '' }
      }

      it 'returns a success response (i.e. to display the "edit" template)' do
        put :update, params: { id: product.id, product: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested product' do
      product = create(:product, user: user, supplier: supplier)
      expect {
        delete :destroy, params: { id: product.id }
      }.to change(Product, :count).by(-1)
    end

    it 'redirects to the products list' do
      delete :destroy, params: { id: product.id }
      expect(response).to redirect_to(products_url)
    end
  end
end
