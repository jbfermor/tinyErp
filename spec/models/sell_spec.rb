require 'rails_helper'

RSpec.describe Sell, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:customer) }
  it { should validate_presence_of(:sell_date) }
  it { should validate_presence_of(:total_sell) }
  it { should validate_numericality_of(:total_sell) }
end
