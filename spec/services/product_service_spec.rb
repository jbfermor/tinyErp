require 'rails_helper'

RSpec.describe ProductService, type: :service do
  let(:user) { create(:user) }
  let(:supplier) { create(:supplier, user: user) }
  let(:product) { build(:product, user: user, supplier: supplier) }
  let(:existing_product) { create(:product, user: user, supplier: supplier) }
  let(:valid_attributes) {
    { product_name: 'ProductName', product_description: 'ProductDescription', supplier_id: supplier.id }
  }

  describe '.create_product' do
    it 'creates a new product with stock 0' do
      ProductService.create_product(product)
      expect(product.stock).to eq(0)
    end

    it 'creates a new product' do
      expect {
        ProductService.create_product(product)
      }.to change(Product, :count).by(1)
    end
  end

  describe '.update_product' do
    it 'updates the product' do
      ProductService.update_product(existing_product, valid_attributes)
      existing_product.reload
      expect(existing_product.product_name).to eq('ProductName')
    end
  end

  describe '.destroy_product' do
    it 'destroys the product' do
      existing_product
      expect {
        ProductService.destroy_product(existing_product)
      }.to change(Product, :count).by(-1)
    end
  end
end
