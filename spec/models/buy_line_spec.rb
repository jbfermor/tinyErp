require 'rails_helper'

RSpec.describe BuyLine, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:buy) }
  it { should belong_to(:product) }
  it { should validate_presence_of(:product_quantity) }
  it { should validate_numericality_of(:product_quantity) }
  it { should validate_presence_of(:total_buy_line) }
  it { should validate_numericality_of(:total_buy_line) }
  it { should define_enum_for(:state).with_values([:creado, :pedido, :entregado_totalmente, :entregado_parcialmente]) }
end
