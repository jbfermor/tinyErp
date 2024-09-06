require 'rails_helper'

RSpec.describe Reception, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:supplier) }
  it { should belong_to(:buy) }
  it { should validate_presence_of(:last_reception_date) }
  it { should define_enum_for(:state).with_values([:entregado_totalmente, :entregado_parcialmente]) }
end
