require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:user) { create(:user) }
  let(:supplier) { create(:supplier, user: user) }
  let(:product) { create(:product, user: user, supplier: supplier) }

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:supplier) }
    it { should have_many(:buy_lines).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:product_name) }
    it { should validate_presence_of(:product_description) }
    it { should validate_presence_of(:price) }
    it { should validate_numericality_of(:price).is_greater_than_or_equal_to(0) }
    it { should validate_presence_of(:stock) }
    it { should validate_numericality_of(:stock).is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:min_stock).is_greater_than_or_equal_to(0).allow_nil }
  end

  describe 'custom validations' do
    it 'is valid with valid attributes' do
      expect(product).to be_valid
    end

    it 'is not valid without a product_name' do
      product.product_name = nil
      expect(product).to_not be_valid
    end

    it 'is not valid without a product_description' do
      product.product_description = nil
      expect(product).to_not be_valid
    end

    it 'is not valid without a stock' do
      product.stock = nil
      expect(product).to_not be_valid
    end

    it 'is not valid with a negative stock' do
      product.stock = -1
      expect(product).to_not be_valid
    end

    it 'is valid without a min_stock' do
      product.min_stock = nil
      expect(product).to be_valid
    end

    it 'is not valid with a negative min_stock' do
      product.min_stock = -1
      expect(product).to_not be_valid
    end
  end
end
