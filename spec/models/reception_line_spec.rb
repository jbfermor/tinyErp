require 'rails_helper'

RSpec.describe ReceptionLine, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:supplier) }
  it { should belong_to(:buy) }
  it { should belong_to(:buy_line) }
  it { should belong_to(:reception) }
  it { should validate_presence_of(:quantity_to_receive) }
  it { should validate_numericality_of(:quantity_to_receive) }
  it { should validate_presence_of(:quantity_received) }
  it { should validate_numericality_of(:quantity_received) }
  it { should define_enum_for(:state).with_values([:entregado_totalmente, :entregado_parcialmente]) }
end
