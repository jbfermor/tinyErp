require 'rails_helper'

RSpec.describe Supplier, type: :model do
  it { should belong_to(:user) }
  it { should validate_presence_of(:nif) }
  it { should validate_uniqueness_of(:nif) }
  it { should validate_presence_of(:commercial_name) }
  it { should validate_uniqueness_of(:commercial_name) }
end
