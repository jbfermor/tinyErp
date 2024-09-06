require 'rails_helper'

RSpec.describe Buy, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:supplier) }
  it { should validate_presence_of(:total_buy) }
  it { should validate_numericality_of(:total_buy) }
  it { should define_enum_for(:state).with_values([:creado, :pedido, :entregado_totalmente, :entregado_parcialmente]) }
end
