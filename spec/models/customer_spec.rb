require 'rails_helper'

RSpec.describe Customer, type: :model do
  it { should belong_to(:user) }
  it { should validate_presence_of(:nif) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:surname1) }
  it { should validate_presence_of(:phone) }
  it { should validate_uniqueness_of(:nif) }
end
