require 'rails_helper'

RSpec.describe BuyService, type: :service do
  let(:user) { create(:user) }
  let(:supplier) { create(:supplier, user: user) }
  let(:buy) { build(:buy, user: user, supplier: supplier) }
  let(:existing_buy) { create(:buy, user: user, supplier: supplier) }
  let(:valid_attributes) {
    { buy_date: Date.today, supplier_id: supplier.id }
  }

  describe '.create_buy' do
    it 'creates a new buy with status "creado"' do
      BuyService.create_buy(buy)
      expect(buy.status).to eq('creado')
    end

    it 'creates a new buy' do
      expect {
        BuyService.create_buy(buy)
      }.to change(Buy, :count).by(1)
    end
  end

  describe '.update_buy' do
    it 'updates the buy' do
      BuyService.update_buy(existing_buy, valid_attributes)
      existing_buy.reload
      expect(existing_buy.buy_date).to eq(Date.today)
    end
  end

  describe '.destroy_buy' do
    it 'destroys the buy' do
      existing_buy
      expect {
        BuyService.destroy_buy(existing_buy)
      }.to change(Buy, :count).by(-1)
    end
  end

  describe '.confirm_buy' do
    it 'confirms the buy' do
      BuyService.confirm_buy(existing_buy)
      existing_buy.reload
      expect(existing_buy.status).to eq('pedido')
    end
  end
end
