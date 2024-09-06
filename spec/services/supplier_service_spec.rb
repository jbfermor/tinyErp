require 'rails_helper'

RSpec.describe SupplierService, type: :service do
  let(:user) { create(:user) }
  let(:supplier) { build(:supplier, user: user) }
  let(:existing_supplier) { create(:supplier, user: user) }
  let(:valid_attributes) {
    { nif: '12345678A', commercial_name: 'SupplierName', contact_person: 'John Doe', address: 'Address', city: 'City', postal_code: '12345', province: 'Province' }
  }

  describe '.create_supplier' do
    it 'creates a new supplier' do
      expect {
        SupplierService.create_supplier(supplier)
      }.to change(Supplier, :count).by(1)
    end
  end

  describe '.update_supplier' do
    it 'updates the supplier' do
      SupplierService.update_supplier(existing_supplier, valid_attributes)
      existing_supplier.reload
      expect(existing_supplier.nif).to eq('12345678A')
    end
  end

  describe '.destroy_supplier' do
    it 'destroys the supplier' do
      existing_supplier
      expect {
        SupplierService.destroy_supplier(existing_supplier)
      }.to change(Supplier, :count).by(-1)
    end
  end
end
