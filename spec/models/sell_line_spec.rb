require 'rails_helper'

RSpec.describe SellLine, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:sell) }
  it { should belong_to(:product) }
  it { should validate_presence_of(:product_quantity) }
  it { should validate_numericality_of(:product_quantity) }
  it { should validate_presence_of(:total_sell_line) }
  it { should validate_numericality_of(:total_sell_line) }
end
